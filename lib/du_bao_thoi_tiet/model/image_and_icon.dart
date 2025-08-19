// Dữ liệu hình ảnh và icon tương ứng với hiện tượng thời tiết
import 'package:flutter/material.dart';

// Hiển thị background tương ứng với thời tiết hiện tại
String getWeatherImage(String? weatherText) {
  if (weatherText == null) return 'Không có dữ liệu';

  final text = weatherText.toLowerCase();
  if (text.contains('mưa')) return 'assets/images/troi_mua.jpg';
  if (text.contains('nắng')) return 'assets/images/troi_nang.webp';
  if (text.contains('mây') || text.contains('trời')) return 'assets/images/troi_may.webp';
  if (text.contains('tuyết')) return 'assets/images/troi_tuyet.jpg';
  
  return 'Không có dữ liệu';
}

// Hiển thị Icon tùy theo thời tiết
IconData getWeatherIcon(String? weatherText) {
  if (weatherText == null) return Icons.help_outline;
  final text = weatherText.toLowerCase();
  if (text.contains('mưa')) return Icons.umbrella;
  if (text.contains("nắng")) return Icons.wb_sunny;
  if (text.contains('mây') || text.contains('trời')) return Icons.cloud;
  if (text.contains('tuyết')) return Icons.ac_unit;
  
  return Icons.help_center;
}