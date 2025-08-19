// Widget hiển thị list button các tỉnh/ thành phố

import 'package:flutter/material.dart';
import 'package:dna/du_bao_thoi_tiet/dio/dio_province.dart';
import 'package:dna/du_bao_thoi_tiet/screen/temperature_screen.dart';

class ProvinceListView extends StatefulWidget {
  final List<Map<String, dynamic>> provinces;
  final DioProvince apiProvince;

  const ProvinceListView({super.key, required this.provinces, required this.apiProvince,});
  @override
  State<ProvinceListView> createState() => _StateProvinceListView();
}

class _StateProvinceListView extends State<ProvinceListView>{

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.provinces.length,
      itemBuilder: (context, index) {
        final p = widget.provinces[index];
        final adminId = (p['id'] ?? '').toString();
        final nameVi = (p['name'] ?? '').toString();
        final nameEn = (p['englishName'] ?? '').toString();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ElevatedButton(
            onPressed: () async {
              final key = await widget.apiProvince.getLocationKey(adminId, nameVi, nameEn);
              if (!mounted) return;
              // Có 1 vài tỉnh không khớp apiKey thì sẽ in log
              if (key == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Không tìm thấy Location Key cho "$nameVi"', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, fontFamily: "Inter"))),
                );
                return;
              }
              // Chuyển sang màn hình temperature screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TemperatureScreen(locationKey: key),
                ),
              );
            },
            child: Text(nameVi),
          ),
        );
      },
    );
  }
}
