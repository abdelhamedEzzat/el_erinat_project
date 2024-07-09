import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';
import 'package:el_erinat/features/admin/persentation/screens/admin_sub_screen/admin_news_screen.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/news_elerinat/user_news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewsOfElerinatScreen extends StatelessWidget {
  const NewsOfElerinatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    bool isAdmin = arguments['isAdmin'];
    bool isAuditor = arguments['isAuditor'];

    return BackGroundAndAppBarAndDaynamicBody(
        alignmentTitle: Alignment.center,
        titleName: MStrings.newsOfElerinat,
        yourBodyOfScreen: Positioned.fill(
            // top: 150.h,
            child: SafeArea(
          child: SingleChildScrollView(
            child: isAdmin == true
                ? const AdminNewsScreen()
                : isAuditor == true
                    ? const UserNews()
                    : const UserNews(),
          ),
        )));
  }
}
