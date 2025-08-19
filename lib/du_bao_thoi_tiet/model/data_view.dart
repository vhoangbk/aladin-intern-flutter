// Dữ liệu hiển thị ở phân SingleScrollView

class ForecastDay {
  final DateTime date;
  final double minTemp;
  final double maxTemp;
  

  ForecastDay({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    // Lấy ngày
    final dateStr = json['Date'] as String? ?? '';
    final date = DateTime.tryParse(dateStr) ?? DateTime.now();

    // Lấy Min / Max, ép về double
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

    // Lấy mô tả thời tiết

    return ForecastDay(
      date: date,
      minTemp: minTemp,
      maxTemp: maxTemp,
    );
  }
}
