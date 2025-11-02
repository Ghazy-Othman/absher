import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/pages/cart_page.dart';
import 'package:mobile/pages/favorite_page.dart';
import 'package:mobile/pages/home/home_page.dart';
import 'package:mobile/pages/make_order_page.dart';
import 'package:mobile/pages/nav_controller.dart';
import 'package:mobile/pages/profile/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentPageIndex = 0;
  bool isVendor = false;

  final List<Widget> _pagesBody = [
    HomePage(),
    FavoritePage(),
    CartPage(),
    // ProfilePage(),
  ];

  final List<AppBar?> _pagesAppBar = [
    null,
    AppBar(
      title: Text("Favorite", style: TextStyle(fontSize: 18.sp)),
      centerTitle: false,
      backgroundColor: Colors.white,
    ),
    AppBar(
      title: Text("Cart", style: TextStyle(fontSize: 18.sp)),
      centerTitle: false,
      backgroundColor: Colors.white,
    ),
    AppBar(
      title: Text("Profile", style: TextStyle(fontSize: 18.sp)),
      centerTitle: false,
      backgroundColor: Colors.white,
    ),
  ];

  @override
  void initState() {
    _pagesAppBar[0] = _buildTopBar();
    bottomIndex.addListener(() {
      if (mounted) {
        setState(() {
          _currentPageIndex = bottomIndex.value;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _pagesAppBar[2] = AppBar(
      title: Text("Cart", style: TextStyle(fontSize: 18.sp)),
      centerTitle: false,
      backgroundColor: Colors.white,
      actionsPadding: EdgeInsets.all(10.w),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightGreen,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => CreateOrderPage()));
          },
          child: Text("Next", style: TextStyle(fontSize: 14.sp)),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _pagesAppBar[_currentPageIndex],
      body: _pagesBody[_currentPageIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  AppBar _buildTopBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Container(
        margin: EdgeInsets.all(5.w),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Search products",
            prefixIcon: Icon(Icons.search, size: 22.sp),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            filled: true,
            fillColor: Colors.lightGreen[100],
            contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_none, color: Colors.black, size: 24.sp),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: _currentPageIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.lightGreen,
      unselectedItemColor: Colors.grey,
      selectedFontSize: 12.sp,
      unselectedFontSize: 12.sp,
      onTap: (value) {
        setState(() {
          _currentPageIndex = value;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home, size: 24.sp), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.star_border, size: 24.sp), label: "Favorite"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined, size: 24.sp), label: "Cart"),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline, size: 24.sp), label: "Profile"),
      ],
    );
  }
}
