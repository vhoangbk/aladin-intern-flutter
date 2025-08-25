// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'weather_mapping.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherMapping _$WeatherMappingFromJson(Map<String, dynamic> json) =>
    WeatherMapping(
      code: json['code'] as int,
      description: json['description'] as String,
      iconUrl: json['iconUrl'] as String,
      isDayIcon: json['isDayIcon'] as bool,
      isNightIcon: json['isNightIcon'] as bool,
      background: json['background'] as String
    );

Map<String, dynamic> _$WeatherMappingToJson(WeatherMapping instance) =>
    <String, dynamic>{
      'code': instance.code,
      'description': instance.description,
      'iconUrl': instance.iconUrl,
      'isDayIcon': instance.isDayIcon,
      'isNightIcon' : instance.isNightIcon,
      'background': instance.background
    };
