import 'package:flutter/material.dart';

class HomeTabbar extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 30, vertical: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Text("Welcome back", style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w400, fontFamily: "Poppins")),
              Text("Stefani Wong", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700, fontFamily: "Poppins"))
            ],
          ),
          SizedBox(width: 70),
          Icon(Icons.notification_add_rounded)           
        ],
      ),
    );
  }
}