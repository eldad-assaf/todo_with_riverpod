import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo_with_riverpod/common/utils/constants.dart';
import 'package:todo_with_riverpod/common/widgets/reuseable_text.dart';
import 'package:todo_with_riverpod/common/widgets/text_style.dart';
import 'package:todo_with_riverpod/common/widgets/width_spacer.dart';
import 'package:todo_with_riverpod/features/onboarding/widgets/page_one.dart';
import 'package:todo_with_riverpod/features/onboarding/widgets/page_two.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: pageController,
          children: const [PageOne(), PageTwo()],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.ease);
                        },
                        child: const Icon(
                          Ionicons.chevron_forward_circle,
                          size: 30,
                          color: Appconst.kLight,
                        ),
                      ),
                      const WidthSpacer(width: 8),
                      ReusableText(
                          text: 'Skip',
                          style:
                              appStyle(16, Appconst.kLight, FontWeight.w500)),
                    ],
                  ),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: 2,
                    effect: const WormEffect(
                        activeDotColor: Appconst.kBlueLight,
                        dotHeight: 12,
                        dotWidth: 16,
                        spacing: 10,
                        dotColor: Appconst.kLight),
                  )
                ],
              )),
        )
      ]),
    );
  }
}
