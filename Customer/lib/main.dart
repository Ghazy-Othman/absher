//
//
//
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/pages/main/main_page.dart';
import 'package:mobile/pages/on_boarding/on_boarding_page.dart';
import 'package:mobile/services/user_service.dart';
import 'package:mobile/services/web_socket_service.dart';
import 'package:mobile/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  ///
  final socket = WebSocketService();
  socket.connect();

  ///
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences _ = await SharedPreferences.getInstance();
  final token = await UserService.getToken();
  String firstPage = token.isEmpty ? "on_boarding" : "main";

  ///
  runApp(MainApp(firstPage: firstPage));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.firstPage});

  final String firstPage;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(412, 798),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Customer App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: firstPage == "main" ? MainPage() : OnboardingPage(),
    );
  }
}
