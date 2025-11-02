///
import 'package:delivery_man/screens/sign_up_pages/choose_vehicle_step.dart';
import 'package:delivery_man/screens/sign_up_pages/controller/register_controller.dart';
import 'package:delivery_man/screens/sign_up_pages/driver_license_photo_step.dart';
import 'package:delivery_man/screens/sign_up_pages/general_info_step.dart';
import 'package:delivery_man/screens/sign_up_pages/id_card_photo_step.dart';
import 'package:delivery_man/screens/sign_up_pages/profile_photo_step.dart';
import 'package:delivery_man/widgets/step_tacker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final RegisterController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(RegisterController());
  }

  int currentStep = 0;

  void goToNextStep() {
    if (currentStep <= 3) {
      setState(() => currentStep++);
    }
  }

  void navBack() {
    if (currentStep >= 1) {
      setState(() {
        currentStep--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  List<Widget> getStepWidgets() => [
    GeneralInformationStep(onNext: goToNextStep),
    ProfilePhotoStep(onNext: goToNextStep),
    IDCardPhotoStep(onNext: goToNextStep),
    DriverLicensePhotoStep(onNext: goToNextStep),
    const ChooseVehicleStep(),
  ];

  @override
  Widget build(BuildContext context) {
    final steps = getStepWidgets();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        scrolledUnderElevation: 0.0 ,
        elevation: 0,
        leading: IconButton(
          onPressed: navBack,
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StepTracker(currentStep: currentStep),
              SizedBox(height: 24.h),
              Expanded(child: SingleChildScrollView(child: steps[currentStep])),
            ],
          ),
        ),
      ),
    );
  }
}
