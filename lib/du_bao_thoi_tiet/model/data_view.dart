// Dữ liệu hiển thị phần dự báo ở phía dưới cuộn

import 'weather_mapping.dart';

class ForecastDay {
  final DateTime date;
  final double minTemp;
  final double maxTemp;
  final WeatherMapping weather;

  ForecastDay({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.weather,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json, List<WeatherMapping> mappingList) {
    final dateStr = json['Date'] as String? ?? '';
    final date = DateTime.tryParse(dateStr) ?? DateTime.now();

    double parseTemp(Map<String, dynamic>? tempJson) {
      if (tempJson == null) return 0.0;
      final value = tempJson['Value'];
      if (value == null) return 0.0;
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    final minTemp = parseTemp(json['Temperature']?['Minimum']);
    final maxTemp = parseTemp(json['Temperature']?['Maximum']);
    final iconCode = json['Day']?['Icon'] as int? ?? 0;
    final description = json['Day']?['IconPhrase'] as String? ?? 'Không rõ';
    final isDayTime = json['Day']?['IsDayTime'] as bool? ?? true;

    // map iconCode với danh sách WeatherMapping theo thời gian
    WeatherMapping weather = mappingList.firstWhere(
      (w) => w.code == iconCode && (isDayTime ? w.isDayIcon : w.isNightIcon),
      orElse: () {
        // fallback: chỉ theo code nếu không match được day/night
        return mappingList.firstWhere(
          (w) => w.code == iconCode,
          orElse: () => WeatherMapping(
            code: iconCode,
            description: description,
            iconUrl: '',
            isDayIcon: true,
            isNightIcon: true,
            background: ''
          ),
        );
      },
    );

    return ForecastDay(
      date: date,
      minTemp: minTemp,
      maxTemp: maxTemp,
      weather: weather,
    );

  }
}

