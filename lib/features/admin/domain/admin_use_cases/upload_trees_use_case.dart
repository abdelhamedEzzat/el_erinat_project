import 'package:dartz/dartz.dart';
import 'package:el_erinat/core/helpers/failure.dart';
import 'package:el_erinat/features/admin/data/model/upload_tree_model.dart';
import 'package:el_erinat/features/admin/domain/admin_entityes/upload_tree_entity.dart';
import 'package:el_erinat/features/admin/domain/repo/admin_repo.dart';

class AddFamilyTree {
  final AdminRepo adminRepo;

  AddFamilyTree({required this.adminRepo});

  Future<Either<Failure, UploadTreeEntity>> call(
    UploadTreeModel uploadTreeModel,
  ) async {
    return await adminRepo.uploadAndSavetree(
      uploadTreeModel: uploadTreeModel,
    );
  }
}

class GetAllFamilyTree {
  final AdminRepo adminRepo;

  GetAllFamilyTree({required this.adminRepo});

  Future<List<UploadTreeModel>> call(String id) async {
    return await adminRepo.getAlltrees();
  }
}

class GetAuditorFamilyTree {
  final AdminRepo adminRepo;

  GetAuditorFamilyTree({required this.adminRepo});

  Future<List<UploadTreeModel>> call(String id) async {
    return await adminRepo.getAuditortrees(id);
  }
}
