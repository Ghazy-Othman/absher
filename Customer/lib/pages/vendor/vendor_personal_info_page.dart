//
//
//
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VendorPersonalInfoPage extends StatefulWidget {
  const VendorPersonalInfoPage({super.key});

  @override
  State<VendorPersonalInfoPage> createState() => _VendorPersonalInfoPageState();
}

class _VendorPersonalInfoPageState extends State<VendorPersonalInfoPage> {
  //
  String vendorName = "Omar";
  String email = "omar@it5.com";
  String description =
      "Welcome to my store! We sell quality products for all your needs.";
  File? backgroundImageFile;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = vendorName;
    _emailController.text = email;
    _descController.text = description;
  }

  void _saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        vendorName = _nameController.text.trim();
        email = _emailController.text.trim();
        description = _descController.text.trim();
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Profile updated successfully!')));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor Profile', style: TextStyle(fontSize: 18.sp)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 160.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16.r),
                      image: backgroundImageFile != null
                          ? DecorationImage(
                              image: FileImage(backgroundImageFile!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: backgroundImageFile == null
                        ? Center(
                            child: Text(
                              "No background image",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.grey[700],
                              ),
                            ),
                          )
                        : null,
                  ),
                  Positioned(
                    bottom: 12.h,
                    right: 12.w,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.camera_alt, size: 18.sp),
                      label: Text('Change', style: TextStyle(fontSize: 14.sp)),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        backgroundColor: Colors.black54,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      'Store Name',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        hintText: 'Enter store name',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 14.h,
                        ),
                      ),
                      validator: (val) => val == null || val.trim().isEmpty
                          ? 'Please enter store name'
                          : null,
                      style: TextStyle(fontSize: 14.sp),
                    ),

                    SizedBox(height: 16.h),

                    // Email
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        hintText: 'Enter email',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 14.h,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.sp),
                    ),

                    SizedBox(height: 16.h),

                    // Description
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: _descController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        hintText: 'Enter store description',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 14.h,
                        ),
                      ),
                      validator: (val) => val == null || val.trim().isEmpty
                          ? 'Please enter description'
                          : null,
                      style: TextStyle(fontSize: 14.sp),
                    ),

                    SizedBox(height: 24.h),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveProfile,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          child: Text(
                            'Save Changes',
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
