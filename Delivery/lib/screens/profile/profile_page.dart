import 'package:delivery_man/constants/api_constants.dart';
import 'package:delivery_man/screens/profile/profile_page_controller.dart';
import 'package:delivery_man/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    controller.fetchProfile();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryBlue,
        title: Text("Profile", style: TextStyle(fontSize: 18.sp)),
        actions: [
          IconButton(
            onPressed: () {
              controller.logout();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: controller.fetchProfile,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                /// Avatar
                CircleAvatar(
                  radius: 50.r,
                  backgroundImage: controller.avatar.value.isNotEmpty
                      ? NetworkImage(
                          controller.avatar.value.replaceFirst(
                            "http://127.0.0.1:8000/",
                            ApiConstants.baseUrl.replaceFirst("api/v1", ""),
                          ),
                        )
                      : null,
                  child: controller.avatar.value.isEmpty
                      ? Icon(Icons.person, color: Colors.white)
                      : null,
                ),
                TextButton(
                  onPressed: () => controller.pickImage("avatar"),
                  child: Text(
                    "Change Avatar",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                SizedBox(height: 20.h),

                /// Profile fields
                _buildProfileTile(context, "Name", controller.name.value, () {
                  _showEditDialog(context, "Name", controller.name.value, (
                    val,
                  ) {
                    controller.updateField("name", val);
                  });
                }),

                _buildProfileTile(
                  context,
                  "Email",
                  controller.email.value,
                  null,
                  readOnly: true,
                ),

                _buildProfileTile(
                  context,
                  "Address",
                  controller.address.value,
                  () {
                    _showEditDialog(
                      context,
                      "Address",
                      controller.address.value,
                      (val) {
                        controller.updateField("address", val);
                      },
                    );
                  },
                ),

                _buildProfileTile(context, "City", controller.city.value, () {
                  _showEditDialog(context, "City", controller.city.value, (
                    val,
                  ) {
                    controller.updateField("city", val);
                  });
                }),

                _buildProfileTile(
                  context,
                  "Gender",
                  controller.gender.value,
                  () {
                    _showEditDialog(
                      context,
                      "Gender",
                      controller.gender.value,
                      (val) {
                        controller.updateField("gender", val);
                      },
                    );
                  },
                ),

                _buildProfileTile(
                  context,
                  "Vehicle Type",
                  controller.vehicleType.value,
                  () {
                    _showEditDialog(
                      context,
                      "Vehicle Type",
                      controller.vehicleType.value,
                      (val) {
                        controller.updateField("vehicle_type", val);
                      },
                    );
                  },
                ),

                _buildProfileTile(
                  context,
                  "National ID",
                  controller.nationalId.value,
                  () {
                    _showEditDialog(
                      context,
                      "National ID",
                      controller.nationalId.value,
                      (val) {
                        controller.updateField("national_id", val);
                      },
                    );
                  },
                ),

                _buildPhotoTile(
                  context,
                  "ID Card Photo",
                  controller.idCardPhoto.value,
                  () {
                    controller.pickImage("id_card_photo");
                  },
                ),

                _buildPhotoTile(
                  context,
                  "Driver License Photo",
                  controller.driverLicensePhoto.value,
                  () {
                    controller.pickImage("driver_license_photo");
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildProfileTile(
    BuildContext context,
    String label,
    String value,
    VoidCallback? onEdit, {
    bool readOnly = false,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      child: ListTile(
        title: Text(label, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(value.isNotEmpty ? value : "Not set"),
        trailing: readOnly
            ? null
            : IconButton(
                icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
                onPressed: onEdit,
              ),
      ),
    );
  }

  Widget _buildPhotoTile(
    BuildContext context,
    String label,
    String url,
    VoidCallback onEdit,
  ) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      child: ListTile(
        title: Text(label, style: Theme.of(context).textTheme.titleMedium),
        subtitle: url.isNotEmpty
            ? Image.network(
                url.replaceFirst(
                  "http://127.0.0.1:8000/",
                  ApiConstants.baseUrl.replaceFirst("api/v1", ""),
                ),
                height: 100.h,
                fit: BoxFit.cover,
              )
            : const Text("No photo uploaded"),
        trailing: IconButton(
          icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
          onPressed: onEdit,
        ),
      ),
    );
  }

  void _showEditDialog(
    BuildContext context,
    String field,
    String oldValue,
    Function(String) onDone,
  ) {
    final controller = TextEditingController(text: oldValue);

    Get.dialog(
      AlertDialog(
        title: Text("Edit $field"),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: "Enter new $field"),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              onDone(controller.text.trim());
              Get.back();
            },
            child: const Text("Done"),
          ),
        ],
      ),
    );
  }
}
