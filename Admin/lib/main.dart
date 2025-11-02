//
//
//
import 'package:admin/services/web_socket_service.dart';
import 'package:admin/theme/app_theme.dart';
import 'package:admin/views/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  ///
  final socket = WebSocketService();
  socket.connect();

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  final token = pref.getString("vendor_token") ?? "";
  final firstPage = token.isNotEmpty ? "main" : "onboard" ;
  runApp( MyApp(firstPage: firstPage));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key , required this.firstPage});
  final String firstPage ;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Vendor App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: SplashScreen(page: firstPage,),
    );
  }
}
