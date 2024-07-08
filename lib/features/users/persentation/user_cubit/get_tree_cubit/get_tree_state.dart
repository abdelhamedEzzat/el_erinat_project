part of 'get_tree_cubit.dart';

sealed class GetTreeState extends Equatable {
  const GetTreeState();

  @override
  List<Object> get props => [];
}

final class GetTreeInitial extends GetTreeState {}

final class GetAllTreeLoading extends GetTreeState {}

final class GetAllTreeError extends GetTreeState {
  final String failure;

  const GetAllTreeError({required this.failure});
}

final class GetAllTreeSuccess extends GetTreeState {
  final List<UploadTreeModel> tree;

  const GetAllTreeSuccess({required this.tree});
}
