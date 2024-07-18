import 'package:el_erinat/features/users/data/model/upload_image.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/work_personal_details_cubit/work_personal_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetCallToUSer extends StatefulWidget {
  const GetCallToUSer({super.key, required this.userUID});
  final String userUID;
  @override
  State<GetCallToUSer> createState() => _GetCallToUSerState();
}

class _GetCallToUSerState extends State<GetCallToUSer> {
  GetCallModel getCall = GetCallModel();
  @override
  void initState() {
    BlocProvider.of<WorkPersonalDetailsCubit>(context)
        .fetchCall(widget.userUID, getCall);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkPersonalDetailsCubit, WorkPersonalDetailsState>(
        builder: (context, state) {
      if (state is GetCallToUserLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is GetCallToUserSuccess) {
        return Container(
          child: Text(state.user.getCall!),
        );
      } else {
        return const Center(
          child: Text("لم يطلب المستخدم الاتصال من قبل المشرف",
              style: TextStyle(color: Colors.red, fontSize: 18)),
        );
      }
    });
  }
}
