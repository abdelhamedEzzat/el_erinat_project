part of 'work_personal_details_cubit.dart';

sealed class WorkPersonalDetailsState {
  const WorkPersonalDetailsState();
}

final class WorkPersonalDetailsInitial extends WorkPersonalDetailsState {}

final class WorkPersonalDetailsLoading extends WorkPersonalDetailsState {}

final class WorkPersonalDetailsError extends WorkPersonalDetailsState {
  final String failure;

  WorkPersonalDetailsError({required this.failure});
}

final class WorkPersonalDetailsSuccess extends WorkPersonalDetailsState {
  final WorkDetailsUserEntityes user;

  WorkPersonalDetailsSuccess({required this.user});
}

class WorkPersonalDetailsLoaded extends WorkPersonalDetailsState {
  final List<WorkModel> users;

  WorkPersonalDetailsLoaded(this.users);
}

final class WorkPersonalDetailsSuccessFile extends WorkPersonalDetailsState {
  final UploadImageEntityes user;

  WorkPersonalDetailsSuccessFile({required this.user});
}

final class WorkPersonalDetailsSuccessIdentety
    extends WorkPersonalDetailsState {
  final UploadImage? user;

  WorkPersonalDetailsSuccessIdentety({this.user});
}

final class WorkPersonalDetailsErrorImage extends WorkPersonalDetailsState {
  final String failure;

  WorkPersonalDetailsErrorImage({required this.failure});
}

final class JobAnaliticsDetailsLoading extends WorkPersonalDetailsState {}

final class JobAnaliticsDetailsError extends WorkPersonalDetailsState {
  final String failure;

  JobAnaliticsDetailsError({required this.failure});
}

final class JobAnaliticsDetailsSuccess extends WorkPersonalDetailsState {
  final JobAnalitics jobAnalitics;

  JobAnaliticsDetailsSuccess({required this.jobAnalitics});
}

//! this states for get call to user

final class GetCallToUserLoading extends WorkPersonalDetailsState {}

final class GetCallToUserError extends WorkPersonalDetailsState {
  final String failure;

  GetCallToUserError({required this.failure});
}

final class GetCallToUserSuccess extends WorkPersonalDetailsState {
  final GetCallFromAuditorEntityes user;

  GetCallToUserSuccess({required this.user});
}

//! this states for UPLOAD call to user

final class UplaodCallToUserLoading extends WorkPersonalDetailsState {}

final class UplaodCallToUserError extends WorkPersonalDetailsState {
  final String failure;

  UplaodCallToUserError({required this.failure});
}

final class UplaodCallToUserSuccess extends WorkPersonalDetailsState {
  final GetCallFromAuditorEntityes user;

  UplaodCallToUserSuccess({required this.user});
}

//! get statics

final class GetJobAnaliticsLoading extends WorkPersonalDetailsState {}

final class GetJobAnaliticsError extends WorkPersonalDetailsState {
  final String failure;

  GetJobAnaliticsError({required this.failure});

  @override
  List<Object> get props => [failure];
}

final class GetJobAnaliticsLoaded extends WorkPersonalDetailsState {
  final JobAnalitics jobAnalitics;

  GetJobAnaliticsLoaded({required this.jobAnalitics});

  @override
  List<Object> get props => [jobAnalitics];
}

//! get info Identity for Auditor

final class WorkPersonalDetailsUserDataForAuditorLoading
    extends WorkPersonalDetailsState {}

final class WorkPersonalDetailsUserDataForAuditorError
    extends WorkPersonalDetailsState {
  final String failure;

  WorkPersonalDetailsUserDataForAuditorError({required this.failure});
}

class WorkPersonalDetailsUserDataForAuditorLoaded
    extends WorkPersonalDetailsState {
  final UploadImage? user;

  WorkPersonalDetailsUserDataForAuditorLoaded(this.user);
}
