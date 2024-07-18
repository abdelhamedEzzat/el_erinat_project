import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/custom_app_bar.dart';
import 'package:el_erinat/features/admin/persentation/screens/admin_sub_screen/admin_suggetions_screen.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/suggestions_and_vote/suggetions_screen/user_add_suggetuion_widget.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: CustomAppBar(
        alignmentTitle: Alignment.center,
        title: Text(
          MStrings.suggestionChoise,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: ColorManger.white),
        ),
      ),
      body: SingleChildScrollView(
          child: isAdmin == true
              ? const AdminSuggetionScreen()
              : isAuditor == true
                  ? const UserAddSuggetionScreen()
                  : const UserAddSuggetionScreen()),
    );
  }
}
