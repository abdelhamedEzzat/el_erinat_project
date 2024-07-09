part of 'news_cubit.dart';

sealed class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

final class NewsInitial extends NewsState {}

final class UploadNewsLoading extends NewsState {}

final class UploadNewsInProgress extends NewsState {}

final class UploadNewsError extends NewsState {
  final String failure;

  const UploadNewsError({required this.failure});
}

final class UploadNewsSuccess extends NewsState {
  final UploadImageAndVideoModel news;

  const UploadNewsSuccess({required this.news});
}

final class GetNewsLoading extends NewsState {}

final class GetNewsError extends NewsState {
  final String failure;

  const GetNewsError({required this.failure});
}

final class GetNewsSuccess extends NewsState {
  final List<UploadImageAndVideoModel> news;

  const GetNewsSuccess({required this.news});
}

class UploadNewsProgress extends NewsState {
  final double progress;

  const UploadNewsProgress({required this.progress});

  @override
  List<Object> get props => [progress];
}
