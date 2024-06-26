import 'package:dartz/dartz.dart';
import 'package:el_erinat/core/helpers/failure.dart';
import 'package:el_erinat/features/admin/data/model/upload_book_model.dart';
import 'package:el_erinat/features/admin/data/model/upload_image_video_model.dart';
import 'package:el_erinat/features/admin/data/model/upload_tree_model.dart';
import 'package:el_erinat/features/admin/domain/admin_entityes/upload_book_entity.dart';
import 'package:el_erinat/features/admin/domain/admin_entityes/upload_image_video_news_entity.dart';
import 'package:el_erinat/features/admin/domain/admin_entityes/upload_tree_entity.dart';

abstract class AdminRepo {
  Future<Either<Failure, UploadBookEntity>> uploadAndSaveBook({
    required UplaodBookModel uploadBookModel,
  });

  Future<List<UplaodBookModel>> getBookLibrary(String uID);

  Future<Either<Failure, UploadImageAndVideoEntity>> uploadAndSavenews({
    required UploadImageAndVideoModel uploadImageAndVideoModel,
  });

  Future<List<UploadImageAndVideoModel>> getAllnews();

  Future<Either<Failure, UploadTreeEntity>> uploadAndSavetree({
    required UploadTreeModel uploadTreeModel,
  });

  Future<List<UploadTreeModel>> getAlltrees();

  Future<List<UploadTreeModel>> getAuditortrees(String uid);
}
