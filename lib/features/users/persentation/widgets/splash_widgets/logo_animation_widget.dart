import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/features/users/persentation/widgets/splash_widgets/logo_image_widget.dart';
import 'package:flutter/material.dart';

class LogoAnimation extends StatelessWidget {
  const LogoAnimation({
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
