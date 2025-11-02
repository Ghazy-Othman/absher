import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/pages/add_variant_page.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  final TextEditingController discountController = TextEditingController();

  bool hasDiscount = false;

  double getFinalPrice() {
    final cost = double.tryParse(costController.text) ?? 0;
    final discount = hasDiscount ? double.tryParse(discountController.text) ?? 0 : 0;
    return cost - (cost * discount / 100);
  }

  List<Map<String, List<String>>> variants = [];
  List<Map<String, String>> attributes = [];

  void _navigateToAddVariant() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddVariantPage()),
    );

    if (result != null) {
      setState(() {
        variants.add(result);
      });
    }
  }

  void _addAttributeField() {
    setState(() {
      attributes.add({"key": "", "value": ""});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product', style: TextStyle(fontSize: 18.sp)),
        backgroundColor: Colors.lightGreen,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("Product Name", nameController),
            SizedBox(height: 12.h),
            _buildTextField("Product Description", descController, maxLines: 3),
            SizedBox(height: 12.h),
            _buildTextField("Cost (\$)", costController, keyboardType: TextInputType.number),
            SizedBox(height: 12.h),

            Row(
              children: [
                Checkbox(
                  value: hasDiscount,
                  activeColor: Colors.lightGreen,
                  onChanged: (value) => setState(() => hasDiscount = value ?? false),
                ),
                Text("Add Discount", style: TextStyle(fontSize: 14.sp)),
              ],
            ),

            if (hasDiscount)
              _buildTextField(
                "Discount (%)",
                discountController,
                keyboardType: TextInputType.number,
              ),
            SizedBox(height: 12.h),

            Text(
              "Final Price: \$${getFinalPrice().toStringAsFixed(2)}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),

            SizedBox(height: 20.h),

            GestureDetector(
              onTap: () {},
              child: Container(
                height: 120.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Icon(Icons.add_a_photo, size: 40.sp, color: Colors.grey),
                ),
              ),
            ),

            SizedBox(height: 24.h),

            Text(
              "Variant",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            ElevatedButton(
              onPressed: _navigateToAddVariant,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                foregroundColor: Colors.white,
                textStyle: TextStyle(fontSize: 14.sp),
              ),
              child: const Text("Add New Variant"),
            ),
            SizedBox(height: 12.h),
            for (var variant in variants)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: variant.entries.map((entry) {
                  return Text(
                    "${entry.key}: ${entry.value.join(', ')}",
                    style: TextStyle(fontSize: 14.sp),
                  );
                }).toList(),
              ),

            SizedBox(height: 24.h),
            Text(
              "Information",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            ElevatedButton(
              onPressed: _addAttributeField,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                foregroundColor: Colors.white,
                textStyle: TextStyle(fontSize: 14.sp),
              ),
              child: const Text("Add Attribute"),
            ),
            SizedBox(height: 12.h),

            for (int i = 0; i < attributes.length; i++)
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Key",
                          hintStyle: TextStyle(fontSize: 14.sp),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                        ),
                        style: TextStyle(fontSize: 14.sp),
                        onChanged: (value) => attributes[i]["key"] = value,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Value",
                          hintStyle: TextStyle(fontSize: 14.sp),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                        ),
                        style: TextStyle(fontSize: 14.sp),
                        onChanged: (value) => attributes[i]["value"] = value,
                      ),
                    ),
                  ],
                ),
              ),

            SizedBox(height: 12.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.lightGreen,
                      side: BorderSide(color: Colors.lightGreen, width: 1.w),
                      textStyle: TextStyle(fontSize: 14.sp),
                    ),
                    child: const Text("Cancel"),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
                      foregroundColor: Colors.white,
                      textStyle: TextStyle(fontSize: 14.sp),
                    ),
                    child: const Text("Add"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label,
      TextEditingController controller, {
        int maxLines = 1,
        TextInputType keyboardType = TextInputType.text,
      }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: TextStyle(fontSize: 14.sp),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 14.sp),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightGreen, width: 1.5.w),
          borderRadius: BorderRadius.circular(8.r),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}
