import 'package:bloc/bloc.dart';
import 'package:el_erinat/features/admin/data/model/upload_tree_model.dart';
import 'package:el_erinat/features/admin/domain/admin_use_cases/upload_trees_use_case.dart';
import 'package:el_erinat/features/admin/domain/repo/admin_repo.dart';
import 'package:equatable/equatable.dart';

part 'tree_elerinat_state.dart';

class TreeElerinatCubit extends Cubit<TreeElerinatState> {
  AdminRepo adminRepo;

  TreeElerinatCubit({required this.adminRepo}) : super(TreeElerinatInitial());

  Future<void> uploadElerinatFamilyForAdmin(UploadTreeModel tree) async {
    emit(UploadTreeLoading());

    final addUserUseCase = AddFamilyTree(adminRepo: adminRepo);
    final result = await addUserUseCase.call(tree);

    result.fold(
      (failure) {
        emit(UploadTreeError(failure: failure.message));
        print('Error adding user: ${failure.message}');
      },
      (user) async {
        emit(UploadTreeSuccess(tree: user as UploadTreeModel));
        print(
            'User added successfully to Firebase and local database: ${tree.familyName}');
      },
    );
  }

  Future<List<UploadTreeModel>> fetchAuditorElerinatFamilyTree(
      String id) async {
    try {
      emit(GetAuditorTreeLoading());
      final image = await adminRepo.getAuditortrees(id);
      if (image.isNotEmpty) {
        treeDataList = image;
        emit(GetAuditorTreeSuccess(tree: image, id: id));
        return image;
      } else {
        emit(const GetAuditorTreeError(failure: 'No image found'));
        return [];
      }
    } catch (e) {
      emit(GetAuditorTreeError(failure: e.toString()));
      return [];
    }
  }

  Future<List<UploadTreeModel>> fetchAllElerinatFamilyTree() async {
    try {
      emit(GetAllTreeLoading());
      final image = await adminRepo.getAlltrees();
      if (image.isNotEmpty) {
        emit(GetAllTreeSuccess(tree: image));
        return image;
      } else {
        emit(const GetAllTreeError(failure: 'No image found'));
        return [];
      }
    } catch (e) {
      emit(GetAllTreeError(failure: e.toString()));
      return [];
    }
  }

  Future<void> updateAuditorElerinatFamilyTree(
      UploadTreeModel uploadTreeModel, int id) async {
    try {
      emit(UpdateAuditorTreeLoading());

      await adminRepo.updateTreeData(uploadTreeModel: uploadTreeModel, id: id);

      emit(UpdateAuditorTreeSuccess());
    } catch (e) {
      emit(UpdateAuditorTreeError(failure: e.toString()));
      print('Error updating user: $e');
    }
  }

  List<UploadTreeModel> treeDataList = [];

  void addNewsItem(UploadTreeModel tree, String id) {
    treeDataList.add(tree);
    emit(GetAuditorTreeSuccess(tree: treeDataList, id: id));
  }

  void addFamilyItem(
    UploadTreeModel tree,
  ) {
    treeDataList.add(tree);
    emit(GetAuditorFamilyTreeSuccess(
      tree: treeDataList,
    ));
  }
}
