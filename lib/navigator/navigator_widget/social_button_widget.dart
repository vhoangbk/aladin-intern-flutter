import 'package:flutter/material.dart';

// Đặc tính chung của button gg và facebook
class SocialButton extends StatelessWidget
{
  @override
  Widget build (BuildContext context)
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: 50,
          child: ElevatedButton(
            onPressed: () {},
            child: Image.asset("assets/google.png"),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero
              ),
            ),
          ),
        ),
        SizedBox(width: 60),
        Container(
          height: 50,
          width: 50,
          child: ElevatedButton(
            onPressed: () {},
            child: Text("f", style: TextStyle(color: Colors.indigo, fontSize: 20, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero
              ),
            ),
          ),
        ),
      ],
    );
  }
}