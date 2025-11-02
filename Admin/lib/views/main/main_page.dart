import 'package:admin/theme/app_theme.dart';
import 'package:admin/views/home/home_page.dart';
import 'package:admin/views/my_products/my_products_page.dart';
import 'package:admin/views/dashboard/dashboard_page.dart';
import 'package:admin/views/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final pages = [
    HomePage(),
    const MyProductsPage(),
    DashboardPage(),
    ProfileTab()

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.darkBlue,
        currentIndex: _currentIndex,
        selectedItemColor: AppTheme.accentBlue,
        unselectedItemColor: Colors.white70,
        selectedFontSize: 12.sp,
        unselectedFontSize: 11.sp,
        iconSize: 22.sp,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: "My Products",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
