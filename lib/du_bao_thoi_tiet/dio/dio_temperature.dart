import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dna/du_bao_thoi_tiet/model/data_view.dart';
import 'package:dna/du_bao_thoi_tiet/model/weather_mapping.dart';

class DioTemperature {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ));

  static const String _apiKey = 'ARSUQKHanpbqFwwFVhpubcAKosOVLsbH';

  Future<List<WeatherMapping>> loadMappingList() async {
    final jsonString = await rootBundle.loadString('assets/weather_mapping/weather_mapping.json');
    final List<dynamic> data = json.decode(jsonString);
    return data.map((item) => WeatherMapping.fromJson(item)).toList();
  }

  Future<Map<String, dynamic>> fetchWeather(String locationKey) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = 'weather_$locationKey';

    // Luôn fetch dữ liệu mới từ server
    final freshData = await _fetchAndUpdateServer(locationKey, prefs, cacheKey);

    // Trả về cả dữ liệu hiện tại, forecast và danh sách mapping
    return {
      'forecast': freshData['forecast'],
      'current': freshData['current'],
      'locationName': freshData['locationName'],
      'mappingList': await loadMappingList(), // thêm mappingList vào
    };
  }

  Future<Map<String, dynamic>> _fetchAndUpdateServer(
    String locationKey, SharedPreferences prefs, String cacheKey) async {
    try {
      final mappingList = await loadMappingList();

      final responses = await Future.wait([
        _dio.get(
          'http://dataservice.accuweather.com/forecasts/v1/daily/5day/$locationKey',
          queryParameters: {'apikey': _apiKey, 'language': 'vi-vn', 'metric': true},
        ),
        _dio.get(
          'http://dataservice.accuweather.com/currentconditions/v1/$locationKey',
          queryParameters: {'apikey': _apiKey, 'language': 'vi-vn', 'details': true},
        ),
        _dio.get(
          'http://dataservice.accuweather.com/locations/v1/$locationKey',
          queryParameters: {'apikey': _apiKey, 'language': 'vi-vn'},
        ),
      ]);

      final forecastResponse = responses[0];
      final currentResponse = responses[1];
      final locationResponse = responses[2];

      if (forecastResponse.statusCode == 200 &&
          currentResponse.statusCode == 200 &&
          locationResponse.statusCode == 200) {
        final forecastData = (forecastResponse.data['DailyForecasts'] as List)
            .map((item) => ForecastDay.fromJson(item, mappingList))
            .toList();

        final currentCondition =
            (currentResponse.data as List).isNotEmpty ? currentResponse.data[0] : null;

        final locationName = locationResponse.data['LocalizedName'];

        await prefs.setString(
          cacheKey,
          jsonEncode({
            'forecast': forecastResponse.data['DailyForecasts'],
            'current': currentCondition,
            'locationName': locationName,
          }),
        );

        return {
          'forecast': forecastData,
          'current': currentCondition,
          'locationName': locationName,
        };
      } else {
        throw Exception(
          'Lỗi server: ${forecastResponse.statusCode ?? currentResponse.statusCode ?? locationResponse.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Kết nối quá lâu. Vui lòng thử lại.');
      }
      if (e.response?.statusCode == 503) {
        throw Exception('Vượt giới hạn API. Vui lòng thử lại sau.');
      }
      throw Exception(e.message);
    }
  }
}


