import 'package:el_erinat/core/back_ground_app/blur_widget.dart';
import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        //   color: Colors.white,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.white
            // Color(0xff292927),
            // Color(0xff292927),
          ],
        ),
      ),
      child: const Stack(
        children: [
          // LogoWidget(),
          // LineImageWidget(),
          // TreeImageWidget(),
          BulrScreen(),
        ],
      ),
    );
  }
}
