import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/widgets/cart_product_card.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final List<Map<String, String>> products = [
    {
      'name': "Acer Nitro KG241Y",
      'description':
          "Acer Nitro KG241Y Sbiip 23.8” Full HD (1920 x 1080) VA Gaming Monitor | AMD FreeSync Premium Technology | 165Hz Refresh Rate | 1ms (VRB) | ZeroFrame Design | 1 x Display Port 1.2 & 2 x HDMI 2.0,Black",
      'cost': "109",
      'image': "assets/products/product_1.jpg",
    },
    {
      'name': "ASUS ROG Strix G16 Gaming Laptop",
      'description':
          "ASUS ROG Strix G16 Gaming Laptop, 165Hz Display, NVIDIA® GeForce RTX™ 4060, Intel Core i7-13650HX, 16GB DDR5, 1TB PCIe Gen4 SSD, Wi-Fi 6E, Windows 11, G614JV-AS74",
      'cost': "1,399",
      'image': "assets/products/product_2.jpg",
    },
    {
      'name': "Hensinple for Samsung Galaxy A16 5G Phone Case,",
      'description':
          "Hensinple for Samsung Galaxy A16 5G Phone Case, Magnetic Samsung A16 5G/4G Case with Screen Protector, Compatible with MagSafe, Not-Yellowing Military Shockproof Cover for Samsung A16 5G Case (Clear)",
      'cost': "10",
      'image': "assets/products/product_3.jpg",
    },
    {
      'name': "Breling Set of 6 Scalloped Placemat 17'' x 13''",
      'description':
          "Breling Set of 6 Scalloped Placemat 17'' x 13'' Embroidered White Placemats Washable Polyester Table Mats for Kitchen Dining Table",
      'cost': "27",
      'image': "assets/products/product_4.jpg",
    },
    {
      'name': "siliteelon Womens Classic-Fit Dress Shirts",
      'description':
          "siliteelon Womens Classic-Fit Dress Shirts Long Sleeve Button Down Wrinkle-Free Stretch Solid Casual Work Office Blouse Top",
      'cost': "75",
      'image': "assets/products/product_5.jpg",
    },
    {
      'name': "GHB Pro",
      'description':
          "GHB Pro Agility Ladder Agility Training Ladder Speed 12 Rung 20ft with Carrying Bag",
      'cost': "13",
      'image': "assets/products/product_6.jpg",
    },
    {
      'name': "Fossil",
      'description':
          "Fossil Men's Nate Quartz Stainless Steel Chronograph Watch",
      'cost': "104",
      'image': "assets/products/product_7.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(12.r),
      itemCount: 5, // Number of cart products
      itemBuilder: (context, index) {
        int x = Random().nextInt(7); // 0–6 range
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: CartProductCard(product: products[x]),
        );
      },
    );
  }
}
