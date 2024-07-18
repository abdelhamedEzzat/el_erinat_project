import 'package:el_erinat/features/users/data/model/user_model.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/add_details_user_entityes.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/analitics.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
sealed class PersonalDetailsState extends Equatable {
  @override
  List<Object> get props => [];
}

final class PersonalDetailsInitial extends PersonalDetailsState {}

final class PersonalDetailsLoading extends PersonalDetailsState {}

final class PersonalDetailsError extends PersonalDetailsState {
  final String failure;

  PersonalDetailsError({required this.failure});

  @override
  List<Object> get props => [failure];
}

final class PersonalDetailsSuccess extends PersonalDetailsState {
  final AddPersonalDetailsUser user;

  PersonalDetailsSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

//! get watinig users

final class WattingPersonalDetailsLoading extends PersonalDetailsState {}

final class WattingPersonalDetailsError extends PersonalDetailsState {
  final String failure;

  WattingPersonalDetailsError({required this.failure});

  @override
  List<Object> get props => [failure];
}

final class WattingPersonalDetailsSuccess extends PersonalDetailsState {
  final List<UserModel> users;

  WattingPersonalDetailsSuccess({required this.users});

  @override
  List<Object> get props => [users];
}

//! get Accepted users

final class AcceptPersonalDetailsLoading extends PersonalDetailsState {}

final class AcceptPersonalDetailsError extends PersonalDetailsState {
  final String failure;

  AcceptPersonalDetailsError({required this.failure});

  @override
  List<Object> get props => [failure];
}

final class AcceptPersonalDetailsSuccess extends PersonalDetailsState {
  final List<UserModel> users;

  AcceptPersonalDetailsSuccess({required this.users});

  @override
  List<Object> get props => [users];
}

//! Update Accepted users

final class UpdateStatusLoading extends PersonalDetailsState {}

final class UpdateStatusError extends PersonalDetailsState {
  final String failure;

  UpdateStatusError({required this.failure});

  @override
  List<Object> get props => [failure];
}

final class UpdateStatusSuccess extends PersonalDetailsState {
  // final AddPersonalDetailsUser user;

  UpdateStatusSuccess();
}

//! DELETE UnAccepted users
final class DeleteUnAcceptedUserLoading extends PersonalDetailsState {}

final class DeleteUnAcceptedUserError extends PersonalDetailsState {
  final String failure;

  DeleteUnAcceptedUserError({required this.failure});

  @override
  List<Object> get props => [failure];
}

final class DeleteUnAcceptedUserSuccess extends PersonalDetailsState {
  // final AddPersonalDetailsUser user;

  DeleteUnAcceptedUserSuccess();
}

//! get all users

final class PersonalDetailsLoaded extends PersonalDetailsState {
  final List<UserModel> users;

  PersonalDetailsLoaded(this.users);

  @override
  List<Object> get props => [users];
}

//! update Role all users
final class UpdateRoleDetailsLoading extends PersonalDetailsState {}

final class UpdateRolePersonalDetailsError extends PersonalDetailsState {
  final String failure;

  UpdateRolePersonalDetailsError({required this.failure});

  @override
  List<Object> get props => [failure];
}

final class UpdateRolePersonalDetailsSuccess extends PersonalDetailsState {
  final AddPersonalDetailsUser user;

  UpdateRolePersonalDetailsSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

final class StatisticsUpdatedLoading extends PersonalDetailsState {
  @override
  List<Object> get props => [];
}

final class StatisticsUpdated extends PersonalDetailsState {
  final int totalDead;
  final int totalMales;
  final int totalFamilies;
  final int personalInFamilies;
  final int allFamilies;
  final int liveMale;
  // final int liveFemale;
  final int totalLive;
  StatisticsUpdated({
    required this.personalInFamilies,
    required this.allFamilies,
    required this.liveMale,
    // required this.liveFemale,
    required this.totalLive,
    required this.totalDead,
    required this.totalMales,
    required this.totalFamilies,
  });

  @override
  List<Object> get props => [totalDead, totalMales, totalFamilies];
}

//! get statics

final class GetStatisticsLoading extends PersonalDetailsState {}

final class GetStatisticsError extends PersonalDetailsState {
  final String failure;

  GetStatisticsError({required this.failure});

  @override
  List<Object> get props => [failure];
}

final class GetStatisticsLoaded extends PersonalDetailsState {
  final Statistics statistics;

  GetStatisticsLoaded({required this.statistics});

  @override
  List<Object> get props => [statistics];
}
//! GET uSER FOR aUDITOR

final class PersonalDetailsForAuditorLoading extends PersonalDetailsState {}

final class PersonalDetailsForAuditorError extends PersonalDetailsState {
  final String failure;

  PersonalDetailsForAuditorError({required this.failure});

  @override
  List<Object> get props => [failure];
}

final class PersonalDetailsForAuditorSuccess extends PersonalDetailsState {
  final List<UserModel> users;

  PersonalDetailsForAuditorSuccess({required this.users});

  @override
  List<Object> get props => [users];
}
