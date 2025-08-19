import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';


class DioProvince {
  final Dio _dio;
  static const String _apiKey = 'BG7Atp7rzVPsUC6PP33Gt5BL3GyV52sN';

  // Map cho các trường hợp đặc biệt có ID là chữ cái (5 thành phố trực thuộc trung ương)
  final Map<String, String> municipalitySearch = const{
    'CT': 'Cần Thơ',
    'DN': 'Đà Nẵng',
    'HN': 'Hà Nội',
    'HP': 'Hải Phòng',
    'SG': 'Hồ Chí Minh',
  };

  DioProvince()
    : _dio = Dio(BaseOptions(
        baseUrl: 'http://dataservice.accuweather.com',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30)
      ));
  
  
  // Lấy danh sách các tỉnh/ thành phố
  Future<List<Map<String, dynamic>>> fetchProvince() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedProvinces = prefs.getString('provinces_v2');
    if(cachedProvinces != null){
      return List<Map<String, dynamic>>.from(jsonDecode(cachedProvinces));
    }

    try{
      final response = await _dio.get(
        '/locations/v1/adminareas/VN',
        queryParameters: {
          'apikey' : _apiKey,
          'language' : 'vi-vn',
        }
      );

      if(response.statusCode == 200){
        final list = (response.data as List).map<Map<String, dynamic>>((e) {
          return {
            'id' : (e['ID'] ?? '').toString(),
            'name' : (e['LocalizedName']).toString(),
            'englishName' : (e['EnglishName'] ?? ''),
          };
        }).toList();

        await prefs.setString('provinces_v2', jsonEncode(list));
        return list;
      } else {
        throw Exception('Lỗi server: ${response.statusCode}');
      } 
    } on DioException catch (e) {
      throw Exception(
        e.response?.statusCode == 503
          ? 'Vượt giới hạn API. Vui lòng thử lại sau'
          : e.message
      );
    }
  } 
  

  // Xử lí để lấy LocationKey
  Future<String?> getLocationKey(String adminId, String localizedName, String englishName) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = 'locKey::$adminId::$localizedName';
    final cached = prefs.getString(cacheKey);
    if(cached != null && cached.isNotEmpty) return cached;

    // Xác định chuỗi cần tìm kiếm
    final String query = municipalitySearch[adminId] ?? localizedName;

    try{
      final res = await _dio.get(
        '/locations/v1/cities/search',
        queryParameters: {
          'apikey' : _apiKey,
          'q' : query,
          'language' : 'vi-vn'
        }
      );

      if(res.statusCode == 200 && res.data is List && (res.data as List).isNotEmpty){
        final List results = res.data as List;

        Map<String, dynamic>? best = results.cast<Map<String, dynamic>>().firstWhere((m) {
          final aa = m['AdministrativeArea'];
          final country = m['Country'];
          final aaName = (aa?['EnglishName'] ?? '').toString();
          final countryId = (country?['ID'] ?? '').toString().toUpperCase();
          return countryId == 'VN' && (aaName == englishName || aaName == localizedName);

        },
        orElse: () => results.first as Map<String, dynamic>,
      );
      
      final key = (best['Key'] ?? '').toString();
      if(key.isNotEmpty){
        await prefs.setString(cacheKey, key);
        return key;
      }
     }
    } catch (e){
      debugPrint("Lỗi lấy locationKey cho $localizedName ($adminId): $e");
    }
    return null;
  }
}