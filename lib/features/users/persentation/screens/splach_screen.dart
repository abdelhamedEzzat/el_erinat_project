import 'package:el_erinat/features/users/persentation/widgets/splash_widgets/logo_animation_widget.dart';
import 'package:flutter/material.dart';

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

    // .whenComplete(() => Navigator.pushNamed(
    //   context,
    // ));
  }

  @override
  void dispose() {
    logoAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LogoAnimation(
          logoAnimationController: logoAnimationController,
          animation: animation),
    );
  }
}
