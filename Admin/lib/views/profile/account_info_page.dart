// //
// //
// //
// import 'package:admin/theme/app_theme.dart';
// import 'package:admin/views/profile/controller/profile_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// class AccountInfoPage extends StatelessWidget {
//   const AccountInfoPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<VendorProfileController>();
//     final theme = Theme.of(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Account Information', style: theme.textTheme.titleLarge),
//         backgroundColor: AppTheme.primaryBlue,
//         foregroundColor: Colors.white,
//       ),
//       body: Obx(() {
//         final v = controller.vendor.value;
//         if (controller.isLoading.value && v == null) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         return SingleChildScrollView(
//           padding: EdgeInsets.all(16.w),
//           child: Column(
//             children: [
//               GestureDetector(
//                 onTap: () => _pickAndUploadImage(controller),
//                 child: CircleAvatar(
//                   radius: 54.r,
//                   backgroundColor: AppTheme.divider,
//                   backgroundImage: (v?.avatarUrl != null)
//                       ? NetworkImage(v!.avatarUrl!) as ImageProvider
//                       : null,
//                   child: (v?.avatarUrl == null)
//                       ? Icon(
//                           Icons.store,
//                           size: 48.r,
//                           color: AppTheme.primaryBlue,
//                         )
//                       : null,
//                 ),
//               ),
//               SizedBox(height: 18.h),
//               _infoRow(
//                 context,
//                 'Name',
//                 v?.name ?? '-',
//                 editable: true,
//                 onEdit: () => _editField(
//                   context,
//                   'Name',
//                   v?.name ?? '',
//                   (val) => controller.updateName(val),
//                 ),
//               ),
//               _infoRow(context, 'Email', v?.email ?? '-', editable: false),
//               _infoRow(
//                 context,
//                 'Phone',
//                 v?.phone ?? '-',
//                 editable: true,
//                 onEdit: () => _editField(
//                   context,
//                   'Phone',
//                   v?.phone ?? '',
//                   (val) => controller.updatePhone(val),
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
//
//   Widget _infoRow(
//     BuildContext ctx,
//     String label,
//     String value, {
//     bool editable = false,
//     VoidCallback? onEdit,
//   }) {
//     final theme = Theme.of(ctx);
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 10.h),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(label, style: theme.textTheme.bodyMedium),
//               if (editable)
//                 GestureDetector(
//                   onTap: onEdit,
//                   child: Text(
//                     'Edit',
//                     style: theme.textTheme.bodyMedium?.copyWith(
//                       color: AppTheme.primaryBlue,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//           SizedBox(height: 6.h),
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               value,
//               style: theme.textTheme.titleMedium?.copyWith(fontSize: 16.sp),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _editField(
//     BuildContext context,
//     String title,
//     String initial,
//     Function(String) onSave,
//   ) {
//     final controller = TextEditingController(text: initial);
//     final theme = Theme.of(context);
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text('Edit $title', style: theme.textTheme.titleMedium),
//         content: TextField(
//           controller: controller,
//           decoration: InputDecoration(labelText: title),
//         ),
//         actions: [
//           TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
//           ElevatedButton(
//             onPressed: () {
//               onSave(controller.text.trim());
//               Get.back();
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppTheme.primaryBlue,
//             ),
//             child: const Text('Save'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _pickAndUploadImage(VendorProfileController controller) async {
//     final picker = ImagePicker();
//     final picked = await picker.pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 80,
//     );
//     if (picked != null) {
//       // You may want to show a loader; the controller has updateAvatar
//       await controller.updateAvatar(picked.path);
//     }
//   }
// }
