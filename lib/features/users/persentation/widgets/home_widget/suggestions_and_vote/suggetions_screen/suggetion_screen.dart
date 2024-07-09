import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';
import 'package:el_erinat/features/admin/persentation/screens/admin_sub_screen/admin_suggetions_screen.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/suggestions_and_vote/suggetions_screen/user_add_suggetuion_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuggetionScreen extends StatefulWidget {
  const SuggetionScreen({super.key});

  @override
  State<SuggetionScreen> createState() => _SuggetionScreenState();
}

class _SuggetionScreenState extends State<SuggetionScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    bool isAdmin = arguments['isAdmin'];
    bool isAuditor = arguments['isAuditor'];
    return BackGroundAndAppBarAndDaynamicBody(
        alignmentTitle: Alignment.center,
        titleName: MStrings.suggestionChoise,
        yourBodyOfScreen: Positioned.fill(
          top: 120.h,
          child: SingleChildScrollView(
              child: isAdmin == true
                  ? const AdminSuggetionScreen()
                  : isAuditor == true
                      ? const UserAddSuggetionScreen()
                      : const UserAddSuggetionScreen()),
        ));
  }
}
