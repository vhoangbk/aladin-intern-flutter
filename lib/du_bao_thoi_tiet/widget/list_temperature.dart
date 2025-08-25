import 'package:flutter/material.dart';
import 'package:dna/du_bao_thoi_tiet/model/data_view.dart';

class ListTemperature extends StatelessWidget {
  final List<ForecastDay> forecastData;

  const ListTemperature({super.key, required this.forecastData});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: forecastData.length,
        itemBuilder: (context, index) {
          final forecast = forecastData[index];
          return Card(
            color: Colors.white70,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: ListTile(
              // Phần icon 
              leading: Image.network(
                forecast.weather.iconUrl,
                width: 40,
                height: 40,
                errorBuilder: (_, __, ___) => const Icon(Icons.cloud, size: 32),
              ),
              title: Text(
                // Định dạng ngày tháng
                'Ngày: ${forecast.date.toString().split(' ')[0]}',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins'),
              ),
              subtitle: Text(
                // Hiển thị dự báo biên độ nhiệt độ 
                'Nhiệt độ: ${forecast.minTemp.toStringAsFixed(1)}°C - ${forecast.maxTemp.toStringAsFixed(1)}°C',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins'),
              ),
            ),
          );
        },
      ),
    );
  }
}
