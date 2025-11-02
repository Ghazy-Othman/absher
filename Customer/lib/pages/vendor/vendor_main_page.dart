import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mobile/pages/add_product_page.dart';
import 'package:mobile/pages/auth/login_page.dart';
import 'package:mobile/pages/vendor/vendor_home_page.dart';
import 'package:mobile/pages/vendor/vendor_profile_page.dart';

class VendorMainPage extends StatefulWidget {
  const VendorMainPage({super.key});

  @override
  State<VendorMainPage> createState() => _VendorMainPageState();
}

class _VendorMainPageState extends State<VendorMainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const VendorHomePage(),
    const VendorProfilePage(isVendorView: true),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onFabPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const AddProductPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
            icon: Icon(Icons.logout, size: 24.w),
          ),
        ],
        backgroundColor: Colors.white,
        title: Text(
          "Absher",
          style: TextStyle(color: Colors.lightGreen, fontSize: 20.sp),
        ),
        centerTitle: false,
        toolbarHeight: 56.h,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.lightGreen,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12.sp,
        unselectedFontSize: 10.sp,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 24.w),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 24.w),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: (_selectedIndex == 0)
          ? FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        onPressed: _onFabPressed,
        child: Icon(Icons.add, color: Colors.white, size: 24.w),
      )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
