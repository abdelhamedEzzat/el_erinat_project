import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_erinat/features/admin/data/model/upload_book_model.dart';
import 'package:el_erinat/features/admin/data/model/upload_image_video_model.dart';
import 'package:el_erinat/features/admin/data/model/upload_tree_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class AdminRemoteDataBaseHelper {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final String refName = 'BookLibrary';
  final String treeName = 'FamilyTree';

  Future<void> uploadFilesToStorage({
    required String imagePath,
    required String pdfPath,
    required UplaodBookModel uploadBookModel,
  }) async {
    final imageFile = File(imagePath);
    final pdfFile = File(pdfPath);
    final imageName = imageFile.uri.pathSegments.last;
    final pdfName = pdfFile.uri.pathSegments.last;

    // Upload image to Firebase Storage
    final imageStorageRef = storage.ref().child('images/$imageName');
    final imageUploadTask = await imageStorageRef.putFile(imageFile);
    final imageUrl = await imageUploadTask.ref.getDownloadURL();

    // Upload PDF to Firebase Storage
    final pdfStorageRef = storage.ref().child('pdfs/$pdfName');
    final pdfUploadTask = await pdfStorageRef.putFile(pdfFile);
    final pdfUrl = await pdfUploadTask.ref.getDownloadURL();

    // Update the uploadBookModel with the remote URLs
    uploadBookModel.remoteImageUrl = imageUrl;
    uploadBookModel.remotepdfUrl = pdfUrl;
    uploadBookModel.pdfName = pdfName;
  }

  Future<void> saveBookDataToFirestore(UplaodBookModel uploadBookModel) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    final String formattedDate = formatter.format(DateTime.now());

    final docRef = firestore.collection('AdminBookLibrary').doc();
    final bookData = UplaodBookModel(
      id: uploadBookModel.id,
      uID: FirebaseAuth.instance.currentUser!.uid,
      localImagePath: uploadBookModel.localImagePath,
      localPdFPath: uploadBookModel.localPdFPath,
      bookdescription: uploadBookModel.bookdescription,
      bookTitle: uploadBookModel.bookTitle,
      remoteImageUrl: uploadBookModel.remoteImageUrl,
      remotepdfUrl: uploadBookModel.remotepdfUrl,
      createdAt: formattedDate,
      pdfName: uploadBookModel.pdfName,
    ).toJson();

    await docRef.set(bookData);
  }

  Future<List<UplaodBookModel>> getBooks() async {
    final querySnapshot = await firestore.collection('AdminBookLibrary').get();
    return querySnapshot.docs.map((doc) {
      return UplaodBookModel.fromJson(doc.data());
    }).toList();
  }

  Future<void> uploadNewsVedioAndImage({
    required String newsPath,
    required UploadImageAndVideoModel uploadImageAndVideoModel,
  }) async {
    final imageFile = File(newsPath);
    final newsName = imageFile.uri.pathSegments.last;

    final imageStorageRef =
        storage.ref(refName).child('ElErinatNews/$newsName');
    final imageUploadTask = await imageStorageRef.putFile(imageFile);
    final imageUrl = await imageUploadTask.ref.getDownloadURL();

    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    final String formattedDate = formatter.format(DateTime.now());

    final newsData = UploadImageAndVideoModel(
      id: uploadImageAndVideoModel.id,
      uID: FirebaseAuth.instance.currentUser!.uid,
      url: imageUrl,
      type: uploadImageAndVideoModel.type,
      path: uploadImageAndVideoModel.path,
      newsTitle: uploadImageAndVideoModel.newsTitle,
      newsSubTitle: uploadImageAndVideoModel.newsSubTitle,
      createdAt: formattedDate,
    ).toMap();

    final docRef = firestore.collection('NewsFromAdmin').doc();

    await docRef.set(newsData);
  }

  Future<List<UploadImageAndVideoModel>> getNews() async {
    final querySnapshot = await firestore.collection('NewsFromAdmin').get();
    return querySnapshot.docs.map((doc) {
      return UploadImageAndVideoModel.fromMap(doc.data());
    }).toList();
  }

  Future<void> uploadFamilyTreePdf({
    required String pdfPath,
    required UploadTreeModel uploadTreeModel,
  }) async {
    final pdfFile = File(pdfPath);

    final pdfName = pdfFile.uri.pathSegments.last;

    // Upload PDF to Firebase Storage
    final pdfStorageRef = storage.ref(treeName).child('pdfs/$pdfName');
    final pdfUploadTask = await pdfStorageRef.putFile(pdfFile);
    final pdfUrl = await pdfUploadTask.ref.getDownloadURL();

    // Save URLs to Firestore
    final docRef = firestore.collection('FamilyTree').doc();
    final bookData = UploadTreeModel(
      id: uploadTreeModel.id,
      uID: FirebaseAuth.instance.currentUser!.uid,
      familyLineage: uploadTreeModel.familyLineage,
      familyName: uploadTreeModel.familyName,
      pdfName: pdfName,
      pdfUrl: pdfUrl,
      pdfPath: pdfPath,
    ).toRemoteMap();

    await docRef.set(bookData);
  }

  Future<List<UploadTreeModel>> getAllTrees() async {
    final querySnapshot = await firestore.collection('FamilyTree').get();
    return querySnapshot.docs.map((doc) {
      return UploadTreeModel.fromRemoteMap(doc.data());
    }).toList();
  }

  Future<List<UploadTreeModel>> getAuditorTrees() async {
    final querySnapshot = await firestore
        .collection('FamilyTree')
        .where("uID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    return querySnapshot.docs.map((doc) {
      return UploadTreeModel.fromRemoteMap(doc.data());
    }).toList();
  }
}


























 //      DocumentSnapshot snapshot = await imageCollection.get();
    //   Map<String, dynamic>? bookData =
    //       snapshot.exists ? snapshot.data() as Map<String, dynamic>? ?? {} : {};
    //   int bookCount =
    //       bookData.containsKey('count') ? bookData['count'] as int : 1;

    //   // Increment the count
    //   int newCount = bookCount + 1;

    //   // Add the new book to the book map
    //   bookData['Book$newCount'] = book.toJson();
    //   bookData['count'] = newCount;

    //   // Update the document in Firestore
    //   await imageCollection.set(bookData);
    // }

    // Future<List<UplaodBookModel>> getBooks() async {
    //   QuerySnapshot querySnapshot =
    //       (await imageCollection.get()) as QuerySnapshot<Object?>;
    //   return   querySnapshot.docs.map((doc) {
    //     return UplaodBookModel.fromJson(doc.data() as Map<String, dynamic>);
    //   }).toList();