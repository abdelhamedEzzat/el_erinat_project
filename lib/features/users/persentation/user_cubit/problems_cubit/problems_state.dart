part of 'problems_cubit.dart';

sealed class ProblemsState extends Equatable {
  const ProblemsState();

  @override
  List<Object> get props => [];
}

final class ProblemsInitial extends ProblemsState {}

final class UploadProblemsLoading extends ProblemsState {}

final class UploadProblemsError extends ProblemsState {
  final String failure;

  const UploadProblemsError({required this.failure});
}

final class UploadProblemsSuccess extends ProblemsState {
  final UserProblemsModel userProblemsModel;

  const UploadProblemsSuccess({required this.userProblemsModel});
}

final class GetProblemsLoading extends ProblemsState {}

final class GetProblemsError extends ProblemsState {
  final String failure;

  const GetProblemsError({required this.failure});
}

final class GetProblemsSuccess extends ProblemsState {
  final List<UserProblemsModel> news;

  const GetProblemsSuccess({required this.news});
}

final class UpdateProblemsLoading extends ProblemsState {}

final class UpdateProblemsError extends ProblemsState {
  final String failure;

  const UpdateProblemsError({required this.failure});
}

final class UpdateProblemsSuccess extends ProblemsState {
  const UpdateProblemsSuccess();
}

final class GetFinishedProblemsLoading extends ProblemsState {}

final class GetFinishedProblemsError extends ProblemsState {
  final String failure;

  const GetFinishedProblemsError({required this.failure});
}

final class GetFinishedProblemsSuccess extends ProblemsState {
  final List<UserProblemsModel> suggetion;

  const GetFinishedProblemsSuccess({required this.suggetion});
}

final class GetProblemsUserLoading extends ProblemsState {}

final class GetProblemsUserError extends ProblemsState {
  final String failure;

  const GetProblemsUserError({required this.failure});
}

final class GetProblemsUserSuccess extends ProblemsState {
  final List<UserProblemsModel> news;

  const GetProblemsUserSuccess({required this.news});
}
