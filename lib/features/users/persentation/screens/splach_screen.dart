import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/config/images_strings.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController logoAnimationController;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    logoAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(logoAnimationController);
    logoAnimationController.forward();
  }

  @override
  void dispose() {
    logoAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LogoWithAnimation(
          logoAnimationController: logoAnimationController,
          animation: animation),
    );
  }
}

class LogoWithAnimation extends StatelessWidget {
  const LogoWithAnimation({
    super.key,
    required this.logoAnimationController,
    required this.animation,
  });

  final AnimationController logoAnimationController;
  final Animation animation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(ColorManger.logoColor, BlendMode.srcIn),
        child: AnimatedBuilder(
          animation: logoAnimationController,
          builder: (context, child) {
            return Opacity(
              opacity: animation.value,
              child: const LogoImage(),
            );
          },
        ),
      ),
    );
  }
}

class LogoImage extends StatelessWidget {
  const LogoImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      ImagesStrings.splash,
      semanticsLabel: MStrings.appName,
    );
  }
}
