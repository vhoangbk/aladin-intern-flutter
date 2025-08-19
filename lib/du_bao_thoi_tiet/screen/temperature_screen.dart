// Màn hình hiển thị nhiệt độ thực + list danh sách nhiệt độ của các ngày tiếp theo

import 'package:dna/du_bao_thoi_tiet/widget/list_temperature.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dna/du_bao_thoi_tiet/dio/dio_temperature.dart';
import 'package:dna/du_bao_thoi_tiet/widget/current_temperature_widget.dart';
import 'package:dna/du_bao_thoi_tiet/model/data_view.dart';
import 'package:dna/du_bao_thoi_tiet/model/image_and_icon.dart';

class TemperatureScreen extends StatefulWidget {
  final String locationKey;
  const TemperatureScreen({super.key, required this.locationKey});

  @override
  State<TemperatureScreen> createState() => _TemperatureScreenState();
}

class _TemperatureScreenState extends State<TemperatureScreen> {
  List<ForecastDay> forecastData = [];
  Map<String, dynamic>? currentCondition;
  String? locationName;
  bool isLoading = true;
  String? errorMessage;
  final DioTemperature _temperatureService = DioTemperature();
  Timer? _timer; 

  @override
  void initState() {
    super.initState();
    loadData(); // fetch lần đầu
    // Cập nhật tự động mỗi 5 phút
    _timer = Timer.periodic(const Duration(minutes: 5), (_) {
      loadData();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  
  // Load dữ liệu để hiển thị trên màn hình
  Future<void> loadData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final data = await _temperatureService.fetchWeather(widget.locationKey);
      if (!mounted) return;

      List<ForecastDay> forecasts = data['forecast'];

      final today = DateTime.now();
      final todayDate = DateTime(today.year, today.month, today.day);

      // Bỏ hết ngày nhỏ hơn hôm nay
      forecasts = forecasts.where((f) {
        final d = DateTime(f.date.year, f.date.month, f.date.day);
        return !d.isBefore(todayDate);
      }).toList();

      //chỉ hiển thị từ ngày mai trở đi ở phần cuộn
      if (forecasts.isNotEmpty) {
        final firstDate = DateTime(
          forecasts[0].date.year,
          forecasts[0].date.month,
          forecasts[0].date.day,
        );
        if (firstDate.isAtSameMomentAs(todayDate)) {
          forecasts = forecasts.sublist(1);
        }
      }

      setState(() {
        forecastData = forecasts;
        currentCondition = data['current'];
        locationName = data['locationName'];
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        // Vuốt để trở lại màn hình danh sách các tỉnh
        behavior: HitTestBehavior.opaque,
        onHorizontalDragUpdate: (details) {
          if (details.primaryDelta != null && details.primaryDelta! > 20) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          }
        },
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            // Xử lí đối với những tình huống bị lỗi thì sẽ in ra log
            : errorMessage != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          errorMessage!, 
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, fontFamily: "Poppins"),
                        ),
                        ElevatedButton(
                          onPressed: loadData,
                          child: const Text('Thử lại', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, fontFamily: "Inter")),
                        ),
                      ],
                    ),
                  )
                  // Hình nền + thông tin + list nhiệt độ
                : Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          getWeatherImage(currentCondition?['WeatherText']),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        children: [
                          CurrentTemperatureWidget(
                            locationName: locationName, 
                            currentCondition: currentCondition
                          ),
                          ListTemperature(forecastData: forecastData)
                        ],
                      )
                    ],
                  ),
      ),
    );
  }
}
