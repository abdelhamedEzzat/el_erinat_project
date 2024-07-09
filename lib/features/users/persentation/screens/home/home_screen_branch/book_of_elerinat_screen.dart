import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/book_elerinat_widget/book_elerinat_body.dart';
import 'package:flutter/material.dart';

class BookOfElerinatScreen extends StatelessWidget {
  const BookOfElerinatScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    bool isAdmin = arguments['isAdmin'];
    bool isAuditor = arguments['isAuditor'];
    return BackGroundAndAppBarAndDaynamicBody(
        alignmentTitle: Alignment.center,
        titleName: MStrings.bookOfElerinat,
        yourBodyOfScreen: BookElerinatBody(
          isAdmin: isAdmin,
          isAuditor: isAuditor,
        ));
  }
}
