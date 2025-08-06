import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeTabbar extends StatefulWidget {
  const HomeTabbar({super.key});

  @override
  State<HomeTabbar> createState() => _HomeTabbarState();
}

class _HomeTabbarState extends State<HomeTabbar> {
  @override
  Widget build(BuildContext context) {
    final _ = context.locale; // rebuild khi ngôn ngữ đổi

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Text(
                "Welcome back".tr(),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Poppins",
                ),
              ),
              const Text(
                "Stefani Wong",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Poppins",
                ),
              )
            ],
          ),
          const SizedBox(width: 70),
          const Icon(Icons.notification_add_rounded)           
        ],
      ),
    );
  }
}
