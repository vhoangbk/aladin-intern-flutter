import 'package:dna/navigator/router/router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  
  // Lấy ngôn ngữ trong máy đang sử dụng 
  final systemLocale =PlatformDispatcher.instance.locale;
  final langCode = systemLocale.languageCode;

  // Nếu không phải en/vi thì mặc định là vi
  final Locale defaultLocale  = (langCode == 'en' || langCode == 'vi')
      ? Locale(langCode)
      : const Locale('vi');
  
  runApp(
    EasyLocalization( 
      supportedLocales: const[Locale('en'), Locale('vi')], 
      path: 'assets/langs',
      fallbackLocale: const Locale('en'),
      startLocale: defaultLocale,
      saveLocale: false,
      child: const MyApp(),
    )

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,

      routerConfig: router,
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(), //
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
    );
  }
}