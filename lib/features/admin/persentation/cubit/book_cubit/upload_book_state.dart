part of 'upload_book_cubit.dart';

sealed class UploadBookState extends Equatable {
  const UploadBookState();

  @override
  List<Object> get props => [];
}

final class UploadBookInitial extends UploadBookState {}

final class UploadBookLoading extends UploadBookState {}

final class UploadBookError extends UploadBookState {
  final String failure;

  const UploadBookError({required this.failure});
}

final class UploadBookSuccess extends UploadBookState {
  final UplaodBookModel book;

  const UploadBookSuccess({required this.book});
}

final class GetBookLoading extends UploadBookState {}

final class GetBookError extends UploadBookState {
  final String failure;

  const GetBookError({required this.failure});
}

final class GetBookSuccess extends UploadBookState {
  final List<UplaodBookModel> book;

  const GetBookSuccess({required this.book});
}
