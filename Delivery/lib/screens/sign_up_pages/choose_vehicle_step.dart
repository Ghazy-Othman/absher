import 'package:delivery_man/constants/images_constants.dart';
import 'package:delivery_man/screens/sign_up_pages/controller/register_controller.dart';
import 'package:delivery_man/theme/app_theme.dart';
import 'package:delivery_man/widgets/vehicle_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChooseVehicleStep extends StatelessWidget {
  const ChooseVehicleStep({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Get.find<RegisterController>();

    final List<Map<String, String>> vehicles = [
      {
        'name': 'Bicycle',
        'desc': 'Eco-friendly and perfect for short distances.',
        'image': ImagesConstants.bicycleVehicle,
      },
      {
        'name': 'E-Bike',
        'desc': 'Electric bike for faster delivery with less effort.',
        'image': ImagesConstants.eBikeVehicle,
      },
      {
        'name': 'Motorcycle',
        'desc': 'Great for medium distances and speed.',
        'image': ImagesConstants.motorcycleVehicle,
      },
      {
        'name': 'Car',
        'desc': 'Ideal for long distance or big packages.',
        'image': ImagesConstants.carVehicle,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What kind of vehicle do you drive?',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20.h),

        //
        Obx(
          () => Column(
            children: List.generate(vehicles.length, (index) {
              final v = vehicles[index];
              return GestureDetector(
                onTap: () => controller.selectVehicle(v['name']!),
                child: VehicleCard(
                  title: v['name']!,
                  description: v['desc']!,
                  imagePath: v['image']!,
                  selected: controller.selectedVehicle.value == v['name'],
                ),
              );
            }),
          ),
        ),

        SizedBox(height: 30.h),

        //
        Obx(() {
          if (controller.isLoading.isTrue) {
            return Center(child: CircularProgressIndicator(color: AppTheme.primaryBlue));
          }
          return SizedBox(
            width: double.infinity,
            height: 48.h,
            child: Obx(() {
              final isSelected = controller.selectedVehicle.value.isNotEmpty;
              return ElevatedButton(
                onPressed: isSelected
                    ? () {
                        controller.register();
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Next',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
              );
            }),
          );
        }),
      ],
    );
  }
}
