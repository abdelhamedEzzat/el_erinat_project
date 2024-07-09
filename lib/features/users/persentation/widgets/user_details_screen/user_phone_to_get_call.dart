import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/features/users/data/model/user_model.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/personal_details_cubit/personal_details_cubit.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/personal_details_cubit/personal_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserPhontToGetCall extends StatelessWidget {
  const UserPhontToGetCall({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManger.logoColor.withOpacity(0.5),
      padding: EdgeInsets.all(10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future:
                BlocProvider.of<PersonalDetailsCubit>(context).fetchAllUsers(),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              final cubitState = context.watch<PersonalDetailsCubit>().state;

              if (cubitState is PersonalDetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (cubitState is PersonalDetailsError) {
                return Center(child: Text('Error: ${cubitState.failure}'));
              } else if (cubitState is PersonalDetailsLoaded) {
                if (cubitState.users.isEmpty) {
                  return const Center(child: Text('No users found'));
                }
                return SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: cubitState.users.length,
                    itemBuilder: (BuildContext context, int index) {
                      UserModel user = cubitState.users[index];
                      return ListTile(
                        title: Text(user.phoneNumber ?? 'No name'),
                      );
                    },
                  ),
                );
              }
              return const Center(child: Text('No users found.'));
            },
          ),
          SizedBox(
            width: 20.w,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              MStrings.yourphoneNumber,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 12.h),
            ),
          ),
        ],
      ),
    );
  }
}
