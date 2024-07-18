part of 'suggtions_and_vote_cubit.dart';

sealed class SuggtionsAndVoteState extends Equatable {
  const SuggtionsAndVoteState();

  @override
  List<Object> get props => [];
}

final class SuggtionsAndVoteInitial extends SuggtionsAndVoteState {}

final class UploadSuggestionLoading extends SuggtionsAndVoteState {}

final class UploadSuggestionError extends SuggtionsAndVoteState {
  final String failure;

  const UploadSuggestionError({required this.failure});
}

final class UploadSuggestionSuccess extends SuggtionsAndVoteState {
  final SuggetionModel suggetionModel;

  const UploadSuggestionSuccess({required this.suggetionModel});
}

final class GetSuggestionLoading extends SuggtionsAndVoteState {}

final class GetSuggestionError extends SuggtionsAndVoteState {
  final String failure;

  const GetSuggestionError({required this.failure});
}

final class GetSuggestionSuccess extends SuggtionsAndVoteState {
  final List<SuggetionModel> news;

  const GetSuggestionSuccess({required this.news});
}

final class UpdateSuggestionLoading extends SuggtionsAndVoteState {}

final class UpdateSuggestionError extends SuggtionsAndVoteState {
  final String failure;

  const UpdateSuggestionError({required this.failure});
}

final class UpdateSuggestionSuccess extends SuggtionsAndVoteState {
  const UpdateSuggestionSuccess();
}

final class GetFinishedSuggestionLoading extends SuggtionsAndVoteState {}

final class GetFinishedSuggestionError extends SuggtionsAndVoteState {
  final String failure;

  const GetFinishedSuggestionError({required this.failure});
}

final class GetFinishedSuggestionSuccess extends SuggtionsAndVoteState {
  final List<SuggetionModel> suggetion;

  const GetFinishedSuggestionSuccess({required this.suggetion});
}
