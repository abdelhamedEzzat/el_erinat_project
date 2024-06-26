import 'package:el_erinat/features/users/data/model/user_model.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/add_details_user_entityes.dart';
import 'package:flutter/material.dart';

@immutable
sealed class PersonalDetailsState {}

final class PersonalDetailsInitial extends PersonalDetailsState {}

final class PersonalDetailsLoading extends PersonalDetailsState {}

final class PersonalDetailsError extends PersonalDetailsState {
  final String failure;

  PersonalDetailsError({required this.failure});
}

final class PersonalDetailsSuccess extends PersonalDetailsState {
  final AddPersonalDetailsUser user;

  PersonalDetailsSuccess({required this.user});
}

class PersonalDetailsLoaded extends PersonalDetailsState {
  final List<UserModel> users;

  PersonalDetailsLoaded(this.users);
}
