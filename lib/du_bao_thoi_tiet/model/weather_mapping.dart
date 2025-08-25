// Mapping để hiển thị theo đúng loại icon, background, số thứ tự, trạng thái

import 'package:json_annotation/json_annotation.dart';

part 'weather_mapping.g.dart';

@JsonSerializable()
class WeatherMapping {
  final int code;               // Mã thời tiết (mapping với AccuWeather)
  final String description;     // Mô tả ngắn gọn
  final String iconUrl;         // Link icon online      
  final bool isDayIcon;         // Các icon chỉ hiển thị ban ngày
  final bool isNightIcon;       // Các icon chỉ hiển thị ban đêm
  final String background;      // Background tương ứng với icon

  WeatherMapping({
    required this.code,
    required this.description,
    required this.iconUrl,
    required this.isDayIcon,
    required this.isNightIcon,
    required this.background
  });

  factory WeatherMapping.fromJson(Map<String, dynamic> json) =>
      _$WeatherMappingFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherMappingToJson(this);
}
