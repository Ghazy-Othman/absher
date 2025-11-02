//
//
//
//
//
//

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/pages/add_variant_page.dart';

class VendorUpdateProductPage extends StatefulWidget {
  const VendorUpdateProductPage({super.key, required this.product});

  final Map<String, dynamic> product;

  @override
  State<VendorUpdateProductPage> createState() =>
      _VendorUpdateProductPageState();
}

class _VendorUpdateProductPageState extends State<VendorUpdateProductPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  final TextEditingController discountController = TextEditingController();

  bool hasDiscount = false;

  //
  double getFinalPrice() {
    final cost = double.tryParse(costController.text) ?? 0;
    final discount = hasDiscount
        ? double.tryParse(discountController.text) ?? 0
        : 0;
    return cost - (cost * discount / 100);
  }

  /*
  * ======================================
  * ======================================
  */

  //
  List<Map<String, List<String>>> variants = [];
  List<Map<String, String>> attributes = [];

  //
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

  //
  void _addAttributeField() {
    setState(() {
      attributes.add({"key": "", "value": ""});
    });
  }

  @override
  void initState() {
    nameController.text = widget.product['name'];
    costController.text = widget.product['cost'].toString();
    descController.text = widget.product['description'];
    if (widget.product['discount'] != null) {
      hasDiscount = true;
      discountController.text = widget.product['discount'].toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
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
            _buildTextField(
              "Cost (\$)",
              costController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12.h),

            // Discount checkbox
            Row(
              children: [
                Checkbox(
                  value: hasDiscount,
                  activeColor: Colors.lightGreen,
                  onChanged: (value) =>
                      setState(() => hasDiscount = value ?? false),
                ),
                const Text("Add Discount"),
              ],
            ),

            // Conditional Discount Field
            if (hasDiscount)
              _buildTextField(
                "Discount (%)",
                discountController,
                keyboardType: TextInputType.number,
              ),

            SizedBox(height: 12.h),

            // Final Price (calculated)
            Text(
              "Final Price: \$${getFinalPrice().toStringAsFixed(2)}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),

            SizedBox(height: 20.h),

            //
            Container(
              height: 160.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Image(image: AssetImage(widget.product['image']) , fit: BoxFit.contain,),
            ),

            SizedBox(height: 14.h),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  ///TODO : Upload new image
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Upload Image"),
              ),
            ),

            /*
            * ======================================
            *         Variants & information
            * ======================================
            */
            const SizedBox(height: 24),
            const Text(
              "Variant",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _navigateToAddVariant,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                foregroundColor: Colors.white,
              ),
              child: const Text("Add New Variant"),
            ),
            const SizedBox(height: 12),
            for (var variant in variants)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: variant.entries.map((entry) {
                  return Text("${entry.key}: ${entry.value.join(', ')}");
                }).toList(),
              ),

            const SizedBox(height: 24),
            const Text(
              "Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _addAttributeField,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                foregroundColor: Colors.white,
              ),
              child: const Text("Add Attribute"),
            ),
            const SizedBox(height: 12),
            for (int i = 0; i < attributes.length; i++)
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(hintText: "Key"),
                      onChanged: (value) => attributes[i]["key"] = value,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(hintText: "Value"),
                      onChanged: (value) => attributes[i]["value"] = value,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.lightGreen,
                      side: const BorderSide(color: Colors.lightGreen),
                    ),
                    child: const Text("Cancel"),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Update"),
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
      decoration: InputDecoration(
        labelText: label,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightGreen),
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
