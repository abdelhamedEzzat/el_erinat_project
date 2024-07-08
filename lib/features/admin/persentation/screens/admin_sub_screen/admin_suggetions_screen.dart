import 'package:el_erinat/features/admin/persentation/widget/suggetion_admin_widget/add_suggetion_form_admin.dart';
import 'package:el_erinat/features/admin/persentation/widget/suggetion_admin_widget/admin_suggetion_items.dart';
import 'package:flutter/material.dart';

class AdminSuggetionScreen extends StatelessWidget {
  const AdminSuggetionScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [AddSuggetionFromAdmin(), AdminSuggetionItem()],
    );
  }
}
