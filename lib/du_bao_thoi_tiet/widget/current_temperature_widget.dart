// Widget hiển thị nhiệt độ theo thời gian thực ở trung tâm màn hình

import 'package:flutter/material.dart';
import 'package:dna/du_bao_thoi_tiet/model/weather_mapping.dart';
import 'package:dna/du_bao_thoi_tiet/dio/dio_temperature.dart';

class CurrentTemperatureWidget extends StatefulWidget {
  final String? locationName;
  final Map<String, dynamic>? currentCondition;

  const CurrentTemperatureWidget({
    super.key,
    required this.locationName,
    required this.currentCondition,
  });

  @override
  State<CurrentTemperatureWidget> createState() =>
      _StateTemperatureWidget();
}

class _StateTemperatureWidget extends State<CurrentTemperatureWidget> {
  late Future<List<WeatherMapping>> _mappingFuture;

  @override
  void initState() {
    super.initState();
    // load danh sách mapping từ JSON
    _mappingFuture = DioTemperature().loadMappingList();
  }

  void refreshData() {
    setState(() {
      _mappingFuture = DioTemperature().loadMappingList();   
    });
  }

  @override
  Widget build(BuildContext context) {
    // Phần hiển thị chiểm 0.6 màn hình
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Tên địa điểm
          Text(
            widget.locationName ?? 'Không rõ',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              fontFamily: "Poppins",
              color: Colors.white
            ),
          ),

          if (widget.currentCondition != null) ...[
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Hiển thị nhiệt kế
                // Nếu nhiệt độ < 20 thì sẽ hiển thị ảnh số 31, >=20 thì hiển thị ảnh số 30
                Image.network(
                  (widget.currentCondition!['Temperature']?['Metric']?['Value'] ?? 0) < 20
                    ? "https://developer.accuweather.com/sites/default/files/31-s.png" // lạnh
                    : "https://developer.accuweather.com/sites/default/files/30-s.png", // nóng
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 6),
                Text(
                 '${(widget.currentCondition!['Temperature']?['Metric']?['Value'] ?? 0).toStringAsFixed(1)}°C',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Poppins",
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            
            // Hiển thị icon hình ảnh và trạng thái 
            FutureBuilder<List<WeatherMapping>>(
              future: _mappingFuture,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const SizedBox();

                final mappings = snapshot.data!;
                final int weatherCode = widget.currentCondition?['WeatherIcon'] ?? 1;

                // Lọc danh sách mapping chỉ theo weatherCode
                final List<WeatherMapping> possibleMatches =
                mappings.where((m) => m.code == weatherCode).toList();

                final WeatherMapping match = possibleMatches.isNotEmpty
                  ? possibleMatches.first
                  : WeatherMapping(
                      code: 0,
                      description: '?',
                      iconUrl: '',
                      isDayIcon: false,
                      isNightIcon: false,
                      background: '',
                    );

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          match.iconUrl,
                          width: 60,
                          height: 60,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.cloud,
                              size: 60,
                              color: Colors.grey,
                            );
                          },
                        ),
                        const SizedBox(width: 3),
                        Text(
                          match.description,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Poppins",
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
              },
            ),


            const SizedBox(height: 10),

            // Độ ẩm
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.water_drop,
                  color: Colors.white,
                  size: 22,
                ),
                const SizedBox(width: 6),
                Text(
                  '${widget.currentCondition!['RelativeHumidity'] ?? '---'}%',
                  style: const TextStyle(
                    fontSize: 22,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
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

