import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Button chon ngon ngu
class LanguageButton extends StatefulWidget
{
  @override
  _LanguageButtonState createState() => _LanguageButtonState();

}

class _LanguageButtonState extends State<LanguageButton>{
  String _language = 'vi';

  @override
  void initState(){
    super.initState();
    _loadLanguage();
  }
  
  // Lấy ngôn ngữ đã lưu
  Future<void> _loadLanguage() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _language = prefs.getString('language') ?? 'vi';
    });
  }
  
  //Lưu ngôn ngữ với lần các lần mở app sau 
  Future<void> _saveLanguage(String lang) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', lang);
  }

  void _showLanguageSelector(BuildContext context){
    showModalBottomSheet(
      context: context, 
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
            ListTile(
              leading: SizedBox (
                height: 25,
                width: 25,
                child: Image.asset("assets/images/united_kingdom.png")               
              ),
              title: const Text("English"),
              onTap: () async {
                await _saveLanguage('en');
                context.setLocale(const Locale('en'));
                Navigator.pop(context);
              },
            ),
         
            ListTile(
              leading: SizedBox(
                height: 25,
                width: 25,
                child: Image.asset("assets/images/vietnamese.jpeg")
              ),
              title: const Text("Vietnamese"),
              onTap: () async{
                await _saveLanguage('vi');
                context.setLocale(const Locale('vi'));
                Navigator.pop(context);
              },
            ),
        ]         
      ) 
    );  
  }

  @override
  Widget build (BuildContext context){
    return SizedBox(
      height: 40,
      width: 40,
      child: ElevatedButton(
        onPressed: () => _showLanguageSelector(context), 
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(6))
        ),
        child: const Icon(Icons.language, size: 18)
      )
    );
  }
}







