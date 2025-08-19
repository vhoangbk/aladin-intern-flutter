import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dna/du_bao_thoi_tiet/model/data_view.dart';

class DioTemperature {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
  ));
  static const String _apiKey = 'BG7Atp7rzVPsUC6PP33Gt5BL3GyV52sN';

  Future<Map<String, dynamic>> fetchWeather(String locationKey) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = 'weather_$locationKey';

    await prefs.remove(cacheKey);

    // Load cache trước để hiển thị ngay
    final cachedData = prefs.getString(cacheKey);
    if (cachedData != null) {
      final data = jsonDecode(cachedData);
      // Trả dữ liệu cache ngay, fetch server sẽ update sau
      _fetchAndUpdateServer(locationKey, prefs, cacheKey);
      return {
        'forecast': (data['forecast'] as List)
            .map((item) => ForecastDay.fromJson(item))
            .toList(),
        'current': data['current'],
        'locationName': data['locationName'],
      };
    } else {
      // Nếu không có cache, fetch server trực tiếp và chờ trả về
      return await _fetchAndUpdateServer(locationKey, prefs, cacheKey);
    }
  }

  // Hàm riêng fetch server và update cache/return dữ liệu mới
  Future<Map<String, dynamic>> _fetchAndUpdateServer(
      String locationKey, SharedPreferences prefs, String cacheKey) async {
    try {
      // Fetch 3 request cùng lúc
      final responses = await Future.wait([
        _dio.get(
          'http://dataservice.accuweather.com/forecasts/v1/daily/5day/$locationKey',
          queryParameters: {'apikey': _apiKey, 'language': 'vi-vn', 'metric': true},
        ),
        _dio.get(
          'http://dataservice.accuweather.com/currentconditions/v1/$locationKey',
          queryParameters: {'apikey': _apiKey, 'language': 'vi-vn', 'details': 'true'},
        ),
        _dio.get(
          'http://dataservice.accuweather.com/locations/v1/$locationKey.json',
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
            .map((item) => ForecastDay.fromJson(item))
            .toList();

        final currentCondition =
            (currentResponse.data as List).isNotEmpty ? currentResponse.data[0] : null;

        final locationName = locationResponse.data['LocalizedName'];

        // Lưu cache mới
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

