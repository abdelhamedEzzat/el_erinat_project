import 'package:el_erinat/core/config/images_strings.dart';
import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/google_auth_cubit/google_auth_cubit.dart';
import 'package:el_erinat/features/users/persentation/widgets/register_screen/or_sign_in_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetLoginWithGoogle extends StatelessWidget {
  const GetLoginWithGoogle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoogleAuthCubit, GoogleAuthState>(
      listener: (context, state) {
        if (state is GoogleAuthSuccess) {
          Navigator.of(context)
              .pushReplacementNamed(ConstantsRouteString.adminHomeScreen);
        }
      },
      builder: (context, state) {
        if (state is GoogleAuthLoading) {
          return const CircularProgressIndicator();
        }
        return OrSignInIcon(
          onTap: () {
            BlocProvider.of<GoogleAuthCubit>(context).signInWithGoogle();
          },
          image: ImagesStrings.googleLogo,
        );
      },
    );
  }
}
