import 'package:flutter/material.dart';
import 'package:dna/du_bao_thoi_tiet/model/data_view.dart';

class ListTemperature extends StatefulWidget{
  final List<ForecastDay> forecastData;
  const ListTemperature({super.key, required this.forecastData});


  @override 
  State<ListTemperature> createState() => _ListTemperatureState();
}

class _ListTemperatureState extends State<ListTemperature>{

  @override
  Widget build (BuildContext context){
    final forecastData = widget.forecastData;
    return Expanded(
      child: ListView.builder(
        // Xử lí phần này có thể cuộn nếu có thể dự báo nhiều ngày 
        physics: const BouncingScrollPhysics(),
        itemCount: forecastData.length,
        itemBuilder: (context, index) {
          final forecast = forecastData[index];
          // Thông tin in trên màn hình
          return ListTile(
            title: Text(
              'Ngày: ${forecast.date.toString().split(' ')[0]}',
              style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400, fontFamily: 'Poppins'),
            ),
            subtitle: Text(
              'Nhiệt độ: ${forecast.minTemp}°C - ${forecast.maxTemp}°C',
              style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400, fontFamily: 'Poppins'),
            ),
          );
        },
      ),
    );
  }
}