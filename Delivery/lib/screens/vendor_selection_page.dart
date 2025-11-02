//
//
//
import 'package:delivery_man/controllers/vendors_selection_controller.dart';
import 'package:delivery_man/screens/main_screen.dart';
import 'package:delivery_man/widgets/categories_grid.dart';
import 'package:delivery_man/widgets/shop_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VendorSelectionPage extends StatefulWidget {
  const VendorSelectionPage({super.key});

  @override
  State<VendorSelectionPage> createState() => _VendorSelectionPageState();
}

class _VendorSelectionPageState extends State<VendorSelectionPage> {
  final VendorSelectionController controller = VendorSelectionController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.h),
            Text(
              'Choose Your Vendor',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Select a category and then choose the shop you want to follow.',
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(height: 20.h),
            CategoryGrid(
              categories: controller.categories,
              selectedCategories: controller.selectedCategories,
              onTap: (category) {
                setState(() => controller.toggleCategory(category));
              },
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 80.h),
                itemCount: controller.shops.length,
                itemBuilder: (_, index) {
                  final shop = controller.shops[index];
                  return ShopCard(
                    name: shop['name']!,
                    description: shop['desc']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        color: Colors.white,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MainPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: Text('Next', style: TextStyle(fontSize: 16.sp , color: Colors.white)),
        ),
      ),
    );
  }
}
