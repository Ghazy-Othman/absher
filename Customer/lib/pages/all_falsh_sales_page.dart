//
//
//

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/pages/product/product_view_page.dart';

class FlashSalesPage extends StatelessWidget {
  FlashSalesPage({super.key});

  final List<Map<String, String>> flashProducts = [
    {
      'name': "Acer Nitro KG241Y",
      'description': "A 165Hz gaming monitor with FreeSync.",
      'cost': "109",
      'image': "assets/products/product_1.jpg",
    },
    {
      'name': "ASUS ROG Strix G16",
      'description': "High-performance gaming laptop.",
      'cost': "1,399",
      'image': "assets/products/product_2.jpg",
    },
    {
      'name': "Galaxy A16 Case",
      'description': "Clear magnetic shockproof case.",
      'cost': "10",
      'image': "assets/products/product_3.jpg",
    },
    {
      'name': "Dress Shirt - Women's",
      'description': "Wrinkle-free stretch office shirt.",
      'cost': "75",
      'image': "assets/products/product_5.jpg",
    },
    {
      'name': "Fossil Watch",
      'description': "Men's stainless steel chronograph.",
      'cost': "104",
      'image': "assets/products/product_7.jpg",
    },
    {
      'name': "Agility Ladder Pro",
      'description': "12-rung agility ladder for training.",
      'cost': "13",
      'image': "assets/products/product_6.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flash Sales", style: TextStyle(fontSize: 18.sp)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(12.w),
        child: GridView.builder(
          itemCount: flashProducts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 12.w,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            final product = flashProducts[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductViewPage(productId: 1),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    Container(
                      height: 150.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12.r),
                        ),
                        color: Colors.blueGrey,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12.r),
                        ),
                        child: Image.asset(
                          product['image'] ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // Product Info
                    Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['name'] ?? '',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            "\$${product['cost']}",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "Flash Deal",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
