//
//
//
import 'package:delivery_man/screens/main_page/main_page.dart';
import 'package:delivery_man/screens/onboarding_screen.dart';
import 'package:delivery_man/services/auth_service.dart';
import 'package:delivery_man/services/web_socket_service.dart';
import 'package:delivery_man/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  ///
  final socket = WebSocketService();
  socket.connect();

  ///
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences _ = await SharedPreferences.getInstance();
  final token = await AuthService.getToken();
  String firstPage = token.isEmpty ? "on_boarding" : "main";

  runApp(MyApp(firstPage: firstPage));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.firstPage});

  final String firstPage;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(412, 798),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Delivery App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: firstPage == "main" ? MainPage() : OnboardingScreen(),
    );
  }
}
