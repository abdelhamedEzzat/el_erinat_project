part of 'tree_elerinat_cubit.dart';

sealed class TreeElerinatState extends Equatable {
  const TreeElerinatState();

  @override
  List<Object> get props => [];
}

final class TreeElerinatInitial extends TreeElerinatState {}

final class UploadTreeInitial extends TreeElerinatState {}

final class UploadTreeLoading extends TreeElerinatState {}

final class UploadTreeError extends TreeElerinatState {
  final String failure;

  const UploadTreeError({required this.failure});
}

final class UploadTreeSuccess extends TreeElerinatState {
  final UploadTreeModel tree;

  const UploadTreeSuccess({required this.tree});
}

final class GetAuditorTreeLoading extends TreeElerinatState {}

final class GetAuditorTreeError extends TreeElerinatState {
  final String failure;

  const GetAuditorTreeError({required this.failure});
}

final class GetAuditorTreeSuccess extends TreeElerinatState {
  final List<UploadTreeModel> tree;
  final String id;

  const GetAuditorTreeSuccess({required this.tree, required this.id});
}

final class UpdateAuditorTreeLoading extends TreeElerinatState {}

final class UpdateAuditorTreeError extends TreeElerinatState {
  final String failure;

  const UpdateAuditorTreeError({required this.failure});
}

final class UpdateAuditorTreeSuccess extends TreeElerinatState {}

final class GetAllTreeLoading extends TreeElerinatState {}

final class GetAllTreeError extends TreeElerinatState {
  final String failure;

  const GetAllTreeError({required this.failure});
}

final class GetAllTreeSuccess extends TreeElerinatState {
  final List<UploadTreeModel> tree;

  const GetAllTreeSuccess({required this.tree});
}

final class GetAuditorFamilyTreeSuccess extends TreeElerinatState {
  final List<UploadTreeModel> tree;

  const GetAuditorFamilyTreeSuccess({
    required this.tree,
  });
}
