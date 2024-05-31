import 'package:el_erinat/features/users/data/model/user_model.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/add_details_user_entityes.dart';
import 'package:flutter/material.dart';

@immutable
sealed class SaveGetFeatchUserDetailsState {}

final class SaveGetFeatchUserDetailsInitial
    extends SaveGetFeatchUserDetailsState {}

final class SaveGetFeatchUserDetailsLoading
    extends SaveGetFeatchUserDetailsState {}

final class SaveGetFeatchUserDetailsError
    extends SaveGetFeatchUserDetailsState {
  final String failure;

  SaveGetFeatchUserDetailsError({required this.failure});
}

final class SaveGetFeatchUserDetailsSuccess
    extends SaveGetFeatchUserDetailsState {
  final AddPersonalDetailsUser user;

  SaveGetFeatchUserDetailsSuccess({required this.user});
}

class UserLoaded extends SaveGetFeatchUserDetailsState {
  final List<UserModel> users;

  UserLoaded(this.users);
}
