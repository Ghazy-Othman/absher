import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile/pages/profile/controller/profile_page_controller.dart';
import 'package:mobile/theme/app_theme.dart';

class ProfileTab extends StatelessWidget {
  final String role = "customer";

  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    controller.fetchProfile(role);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryBlue,
        actions: [
          IconButton(
            onPressed: () {
              controller.logout();
            },
            icon: Icon(Icons.logout),
          ),
        ],
        title: Text("Profile", style: TextStyle(fontSize: 18.sp)),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50.r,
                backgroundImage: controller.avatar.value.isNotEmpty
                    ? NetworkImage(controller.avatar.value)
                    : null,
                child: controller.avatar.value.isEmpty
                    ? Icon(Icons.person, color: Colors.white)
                    : null,
              ),
              TextButton(
                onPressed: () => controller.pickImage(role),
                child: Text(
                  "Change Avatar",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              SizedBox(height: 20.h),

              _buildProfileTile(context, "Name", controller.name.value, () {
                _showEditDialog(context, "Name", controller.name.value, (val) {
                  controller.updateField(role, "name", val);
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
                      controller.updateField(role, "address", val);
                    },
                  );
                },
              ),
            ],
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

  void _showEditDialog(
    BuildContext context,
    String field,
    String oldValue,
    Function(String) onDone,
  ) {
    final textController = TextEditingController(text: oldValue);

    Get.dialog(
      AlertDialog(
        title: Text("Edit $field"),
        content: TextField(
          controller: textController,
          decoration: InputDecoration(hintText: "Enter new $field"),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              onDone(textController.text.trim());
              Get.back();
            },
            child: const Text("Done"),
          ),
        ],
      ),
    );
  }
}
