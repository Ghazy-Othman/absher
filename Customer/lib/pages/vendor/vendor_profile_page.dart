import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/pages/vendor/vendor_personal_info_page.dart';
import 'package:mobile/widgets/vendor/vendor_home_product_card.dart';

class VendorProfilePage extends StatefulWidget {
  final bool isVendorView;

  const VendorProfilePage({super.key, required this.isVendorView});

  @override
  State<VendorProfilePage> createState() => _VendorProfilePageState();
}

class _VendorProfilePageState extends State<VendorProfilePage> {
  int selectedCategoryIndex = 0;

  final List<String> categories = [
    "Laptops",
    "Mobiles",
    "Watches",
    "Clothes",
    "Accessories",
  ];

  final List<Map<String, String>> allProducts = [
    {
      'name': 'Gaming Laptop',
      'image': 'assets/products/product_1.jpg',
      'category': 'Laptops',
    },
    {
      'name': 'Smart Watch',
      'image': 'assets/products/product_7.jpg',
      'category': 'Watches',
    },
    {
      'name': 'Samsung Mobile',
      'image': 'assets/products/product_3.jpg',
      'category': 'Mobiles',
    },
    {
      'name': 'T-Shirt',
      'image': 'assets/products/product_5.jpg',
      'category': 'Clothes',
    },
  ];

  void _deleteCategory(int index) {
    setState(() {
      categories.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vendorName = "TechVendor";
    final vendorDescription = "Best electronics & gadgets provider";

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          SizedBox(
            height: 200.h,
            child: Stack(
              children: [
                ///TODO : Get info from API
                Container(
                  width: double.infinity,
                  height: 150.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/ads/ad_1.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                //
                Positioned(
                  bottom: 10.h,
                  left: 16.w,
                  right: 16.w,
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 6.r),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28.r,
                          backgroundImage: const AssetImage(
                            'assets/products/product_1.jpg',
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vendorName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                              Text(
                                vendorDescription,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.sp,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12.w),
                        if (widget.isVendorView)
                          IconButton(
                            onPressed: () {
                              Navigator.of(
                                context,
                              ).push(MaterialPageRoute(
                                  builder: (_) => const VendorPersonalInfoPage()));
                            },
                            icon: Icon(Icons.settings, color: Colors.lightGreen),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50.h),

          // Conditional content
          Expanded(
            child: widget.isVendorView
                ? _buildCategoryManagerView()
                : _buildCustomerView(),
          ),
        ],
      ),
    );
  }

  /// Customer View
  Widget _buildCustomerView() {
    final selectedCategory = categories[selectedCategoryIndex];
    final filteredProducts =
    allProducts.where((p) => p['category'] == selectedCategory).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Categories Tabs
        SizedBox(
          height: 40.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            itemBuilder: (context, index) {
              final isSelected = selectedCategoryIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategoryIndex = index;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  margin: EdgeInsets.only(right: 8.w),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.lightGreen : Colors.grey[200],
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Center(
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        SizedBox(height: 12.h),

        // Product List
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: VendorHomeProductCard(
                  navToProductPage: false,
                  name: filteredProducts[index]['name']!,
                  imagePath: filteredProducts[index]['image']!,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Vendor View
  Widget _buildCategoryManagerView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Categories",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12.h),
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.lightGreen[100],
                  margin: EdgeInsets.only(bottom: 10.h),
                  child: ListTile(
                    title: Text(categories[index], style: TextStyle(fontSize: 14.sp)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red, size: 24.w),
                      onPressed: () => _deleteCategory(index),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 8.h),
          Center(
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.add, color: Colors.black, size: 20.w),
              label: Text(
                "Add Category",
                style: TextStyle(color: Colors.black, fontSize: 14.sp),
              ),
            ),
          ),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }
}
