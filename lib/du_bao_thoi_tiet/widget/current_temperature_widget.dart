// Widget hiển thị nhiệt độ theo thời gian thực ở trung tâm màn hình

import 'package:flutter/material.dart';
import 'package:dna/du_bao_thoi_tiet/model/image_and_icon.dart';

class CurrentTemperature extends StatefulWidget {
  final String? locationName;
  final Map<String, dynamic>? currentCondition;

  const CurrentTemperature({super.key, required this.locationName, required this.currentCondition});
  @override
  State<CurrentTemperature> createState() => _StateTemperatureWidget();

}

class _StateTemperatureWidget extends State<CurrentTemperature>{

  @override
  Widget build(BuildContext context) {
    // Phần hiển thị nhiệt độ thực sẽ chiếm 0.6 màn hình
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.locationName ?? 'Không rõ',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              fontFamily: "Poppins",
              color: Colors.black,
            ),
          ),
          if (widget.currentCondition != null) ...[
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.thermostat,
                  color: Colors.black,
                  size: 32,
                ),
                const SizedBox(width: 6),
                Text(
                  '${(widget.currentCondition!['Temperature']?['Metric']?['Value'] ?? 0).toStringAsFixed(1)}°C',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  getWeatherIcon(widget.currentCondition?['WeatherText']),
                  color: Colors.black,
                  size: 28,
                ),
                const SizedBox(width: 6),
                Text(
                  widget.currentCondition!['WeatherText'] ?? 'Không rõ',
                  style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w700, fontFamily: "Poppins",
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.water_drop,
                  color: Colors.black,
                  size: 22,
                ),
                const SizedBox(width: 6),
                Text(
                  '${widget.currentCondition!['RelativeHumidity'] ?? '---'}%',
                  style: const TextStyle(
                    fontSize: 22,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
