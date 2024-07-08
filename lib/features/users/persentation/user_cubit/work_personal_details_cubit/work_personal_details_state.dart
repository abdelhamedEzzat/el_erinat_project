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
