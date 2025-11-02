import 'package:admin/views/onboarding/controller/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  final List<Map<String, String>> pages = const [
    {
      'title': 'Manage your Products',
      'subtitle': 'Add, edit and organize product listings easily.',
      'image': 'assets/images/onboard1.png',
    },
    {
      'title': 'Orders & Dashboard',
      'subtitle': 'View orders, sales and track performance.',
      'image': 'assets/images/onboard2.png',
    },
    {
      'title': 'Delivery Requests',
      'subtitle': 'Accept or reject delivery requests and stay updated.',
      'image': 'assets/images/onboard3.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    final PageController pageController = PageController();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).primaryColor,
        actions: [
          TextButton(
            onPressed: () => Get.offNamed('/login'),
            child: Text(
              'Skip',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: pages.length,
                onPageChanged: controller.setPage,
                itemBuilder: (context, index) {
                  final p = pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * 0.38,
                          child: Image.asset(p['image']!, fit: BoxFit.contain),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          p['title']!,
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(fontSize: 20),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          p['subtitle']!,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Obx(() {
              final current = controller.pageIndex.value;
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    Row(
                      children: List.generate(pages.length, (i) {
                        final active = i == current;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: active ? 18 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: active
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).dividerColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        );
                      }),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        if (current < pages.length - 1) {
                          pageController.animateToPage(
                            current + 1,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                          controller.setPage(current + 1);
                        } else {
                          Get.offNamed('/login');
                        }
                      },
                      child: Text(
                        current < pages.length - 1 ? 'Next' : 'Get Started',
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
