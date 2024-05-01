import 'dart:ui';

import 'package:flutter/material.dart';

class BulrScreen extends StatelessWidget {
  const BulrScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
        child: Container(
            // color: Colors.black.withOpacity(0.2)
            ),
      ),
    );
  }
}
