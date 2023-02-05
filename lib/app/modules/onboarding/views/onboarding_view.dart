import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:nft/app/modules/onboarding/controllers/onboarding_controller.dart';
import 'package:nft/app/routes/app_pages.dart';

final pages = [
  const PageData(
    icon: Icons.bubble_chart,
    title: "Connecting people \ntogether",
    bgColor: Color(0xFF0043D0),
    textColor: Colors.white,
    lottieFile: "assets/lottie/ob11.json",
    index: 0,
  ),
  const PageData(
    icon: Icons.format_size,
    title: "Stay in touch \nwith people",
    textColor: Colors.white,
    bgColor: Color(0xFFFDBFDD),
    lottieFile: "assets/lottie/ob22.json",
    index: 1,
  ),
  const PageData(
    icon: Icons.hdr_weak,
    title: "Connect with friends",
    bgColor: Color(0xFFFFFFFF),
    lottieFile: "assets/lottie/ob33.json",
    index: 2,
  ),
];

class OnboardingView extends StatelessWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final controller = Get.find<OnboardingController>();
    return Scaffold(
      body: ConcentricPageView(
        colors: pages.map((p) => p.bgColor).toList(),
        radius: screenWidth * 0.1,
        onFinish: () {
          Get.offAllNamed(Routes.HOME);
        },
        // curve: Curves.ease,
        nextButtonBuilder: (context) => Padding(
          padding: const EdgeInsets.only(left: 3), // visual center
          child: Icon(
            Icons.navigate_next,
            size: screenWidth * 0.08,
          ),
        ),
        // itemCount: pages.length,
        duration: const Duration(milliseconds: 1500),
        // opacityFactor: 2.0,
        // scaleFactor: 0.2,
        // verticalPosition: 0.7,
        // direction: Axis.vertical,
        itemCount: pages.length,
        // physics: NeverScrollableScrollPhysics(),
        itemBuilder: (index) {
          final page = pages[index % pages.length];
          return SafeArea(
            child: _Page(page: page),
          );
        },
      ),
    );
  }
}

class PageData {
  final String? title;
  final int index;
  final String? lottieFile;
  final IconData? icon;
  final Color bgColor;
  final Color textColor;

  const PageData({
    required this.index,
    this.title,
    this.lottieFile,
    this.icon,
    this.bgColor = Colors.white,
    this.textColor = Colors.black,
  });
}

class _Page extends StatelessWidget {
  final PageData page;

  const _Page({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    space(double p) => SizedBox(height: screenHeight * p / 100);
    return Column(
      children: [
        // space(8),
        if (page.index == 0) space(15),
        if (page.index == 1) space(10),
        if (page.index == 2) space(16),
        _LottieCustom(
          page: page,
        ),
        if (page.index == 1) space(8),
        if (page.index == 2) space(8),
        AnimatedText(page: page),
      ],
    );
  }
}

class AnimatedText extends StatelessWidget {
  const AnimatedText({
    Key? key,
    required this.page,
  }) : super(key: key);

  final PageData page;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: page.index == 2 ? page.textColor : Colors.white,
                fontSize: 28,
              ) ??
          TextStyle(
            color: page.index == 2 ? Colors.blue : Colors.white,
            fontSize: 20,
          ),
      child: AnimatedTextKit(
        repeatForever: true,
        animatedTexts: [
          TypewriterAnimatedText(page.title ?? ""),
        ],
      ),
    );
  }
}

class _Text extends StatelessWidget {
  const _Text({
    Key? key,
    required this.page,
    this.style,
  }) : super(key: key);

  final PageData page;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      page.title ?? '',
      style: TextStyle(
        color: page.textColor,
        fontWeight: FontWeight.w600,
        fontFamily: 'Helvetica',
        letterSpacing: 0.0,
        fontSize: 18,
        height: 1.2,
      ).merge(style),
      textAlign: TextAlign.center,
    );
  }
}

//

class _LottieCustom extends StatelessWidget {
  final PageData page;
  const _LottieCustom({required this.page, super.key});

  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(
      page.lottieFile ?? "",
      height: page.index == 2 ? 300 : null,
    );
  }
}
