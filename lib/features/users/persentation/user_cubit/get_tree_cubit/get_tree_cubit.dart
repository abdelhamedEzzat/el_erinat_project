import 'package:bloc/bloc.dart';
import 'package:el_erinat/features/admin/data/model/upload_tree_model.dart';
import 'package:el_erinat/features/admin/domain/repo/admin_repo.dart';
import 'package:equatable/equatable.dart';

part 'get_tree_state.dart';

class GetTreeCubit extends Cubit<GetTreeState> {
  final AdminRepo adminRepo;
  GetTreeCubit({required this.adminRepo}) : super(GetTreeInitial());

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
}
