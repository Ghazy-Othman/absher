import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddVariantPage extends StatefulWidget {
  const AddVariantPage({super.key});

  @override
  State<AddVariantPage> createState() => _AddVariantPageState();
}

class _AddVariantPageState extends State<AddVariantPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController countController = TextEditingController();
  List<TextEditingController> valueControllers = [];

  void _generateFields(int count) {
    setState(() {
      valueControllers = List.generate(count, (_) => TextEditingController());
    });
  }

  void _onConfirm() {
    final name = nameController.text.trim();
    final values = valueControllers
        .map((c) => c.text.trim())
        .where((v) => v.isNotEmpty)
        .toList();

    if (name.isNotEmpty && values.isNotEmpty) {
      Navigator.pop(context, {name: values});
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    countController.dispose();
    for (var c in valueControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Variant", style: TextStyle(fontSize: 18.sp)),
        backgroundColor: Colors.lightGreen,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: nameController,
                          style: TextStyle(fontSize: 14.sp),
                          decoration: InputDecoration(
                            labelText: "Variant Name",
                            labelStyle: TextStyle(fontSize: 14.sp),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        TextField(
                          controller: countController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 14.sp),
                          decoration: InputDecoration(
                            labelText: "Number of Values",
                            labelStyle: TextStyle(fontSize: 14.sp),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          onChanged: (value) {
                            final count = int.tryParse(value) ?? 0;
                            _generateFields(count);
                          },
                        ),
                        SizedBox(height: 16.h),

                        ...valueControllers.map(
                              (c) => Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: TextField(
                              controller: c,
                              style: TextStyle(fontSize: 14.sp),
                              decoration: InputDecoration(
                                labelText: "Value",
                                labelStyle: TextStyle(fontSize: 14.sp),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 32.h),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: ElevatedButton(
                      onPressed: _onConfirm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen,
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(fontSize: 16.sp),
                      ),
                      child: const Text("Confirm"),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
