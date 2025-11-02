import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({super.key});

  @override
  State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  String selectedLanguageCode = 'en'; // Default

  final List<Map<String, String>> languages = [
    {'name': 'English', 'code': 'en'},
    {'name': 'Arabic', 'code': 'ar'},
    {'name': 'Spanish', 'code': 'es'},
    {'name': 'French', 'code': 'fr'},
    {'name': 'German', 'code': 'de'},
  ];

  void _onLanguageSelect(String code) {
    setState(() {
      selectedLanguageCode = code;
    });

    // You can add your own logic here to apply the selected language later.
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Selected: ${code.toUpperCase()}')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Language', style: TextStyle(fontSize: 18.sp)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: ListView.builder(
          itemCount: languages.length,
          itemBuilder: (context, index) {
            final lang = languages[index];
            final isSelected = lang['code'] == selectedLanguageCode;
            return Container(
              margin: EdgeInsets.only(bottom: 12.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: isSelected ? Colors.lightGreen[100] : Colors.white,
                border: Border.all(
                  color: isSelected ? Colors.lightGreen : Colors.grey.shade300,
                  width: 1.2,
                ),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                title: Text(
                  lang['name']!,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                trailing: isSelected
                    ? Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () => _onLanguageSelect(lang['code']!),
              ),
            );
          },
        ),
      ),
    );
  }
}
