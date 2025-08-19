// Màn hình list button các tỉnh

import 'dart:async';
import 'package:dna/du_bao_thoi_tiet/dio/dio_province.dart';
import 'package:dna/du_bao_thoi_tiet/widget/list_province_widget.dart';
import 'package:flutter/material.dart';


class ProvinceScreen extends StatefulWidget {
  const ProvinceScreen({super.key});

  @override
  State<ProvinceScreen> createState() => _ProvinceScreenState();
}

class _ProvinceScreenState extends State<ProvinceScreen> {
  final DioProvince apiProvince = DioProvince();
  List<Map<String, dynamic>> provinces = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadProvinces();
  }
  
  // Load danh sách tỉnh
  Future<void> loadProvinces() async {
    try{
      final list = await apiProvince.fetchProvince();
      setState(() {
        provinces = list;
        isLoading = false;
      });
    } catch(e){
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }

  }
 
  // List button danh sách các tỉnh thành
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách tỉnh/thành phố', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, fontFamily: "Poppins", color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
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
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                            errorMessage = null;
                          });
                          loadProvinces();
                        },
                        child: const Text('Thử lại', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, fontFamily: "Inter")),
                      ),
                    ],
                  ),
                )
              : ProvinceListView(
                  provinces: provinces,
                  apiProvince: apiProvince,
                )
    );
  }
}

