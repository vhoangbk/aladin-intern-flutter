import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonTabbar extends StatelessWidget
{
  final String title;
  final VoidCallback? onRightPressed;
  
  ButtonTabbar({
    Key? key,
    required this.title,
    this.onRightPressed,

  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      width: double.infinity, 
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
      child: Row(
        children: [
          // Xu li button goc trai
          SizedBox(
            height: 40,
            width: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(6)
                )
              ),                 
              onPressed: () {
                context.pop();
              },
              child: Text("<"),                
            ),
          ),
              
          Spacer(), // Tiêu đề ở giữa
          Text(title, style: TextStyle(fontFamily: "Poppins", fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),),  
          Spacer(), // Tiêu đề ở giữa

          // Xu li button goc phai 
          SizedBox(
            height: 40,
            width: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(6)
                )
              ),                 
              onPressed: (){}, 
              child: Text(".."),                
            ),
          ),      
        ]
      )
    );
  }
}

