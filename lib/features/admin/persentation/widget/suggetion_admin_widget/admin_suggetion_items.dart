import 'package:el_erinat/features/admin/persentation/widget/suggetion_admin_widget/get_watting_and_finished_suggetion_screen.dart';
import 'package:flutter/material.dart';

import 'package:el_erinat/features/users/data/repo/user_repo_impelmentation.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_local_data_source.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_remote_data_source.dart';

class AdminSuggetionItem extends StatelessWidget {
  const AdminSuggetionItem({super.key});

  @override
  Widget build(BuildContext context) {
    // UserRepoImplementation userRepoImplementation = UserRepoImplementation(
    //     localDatabaseHelper: LocalDatabaseHelper(),
    //     userRemoteDataSource: UserRemoteDataSource());

    return const GetWattingAndFinishedSuggetionsApp(
      isWaiting: true,
      // future: userRepoImplementation.getWattingSuggetionsToAuditor()
    );
  }
}
