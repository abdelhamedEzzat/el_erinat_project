import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_erinat/core/local_%20notification/notification.dart';
import 'package:el_erinat/features/admin/data/model/upload_book_model.dart';
import 'package:el_erinat/features/admin/data/model/upload_image_video_model.dart';
import 'package:el_erinat/features/admin/data/model/upload_tree_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:video_compress/video_compress.dart';

class AdminRemoteDataBaseHelper {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final String refName = 'BookLibrary';
  final String treeName = 'FamilyTree';

  //
  //!  Upload Book To Storage
  //
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

  //
  //!  Upload Book To fireStore
  //

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

  //
  //!  get Book from fireStore
  //

  Future<List<UplaodBookModel>> getBooks() async {
    final querySnapshot = await firestore.collection('AdminBookLibrary').get();
    return querySnapshot.docs.map((doc) {
      return UplaodBookModel.fromJson(doc.data());
    }).toList();
  }

  //
  //!  upload News image and video to fireStore
  //

  Future<String> uploadNewsVedioAndImageToStorage({
    required String newsPath,
    required UploadImageAndVideoModel uploadImageAndVideoModel,
  }) async {
    try {
      String fileName = basename(newsPath);
      File file = File(newsPath);
      String downloadUrl;

      // Show initial notification
      const AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
        'upload_channel',
        'Upload Progress',
        channelDescription: 'Shows the progress of file uploads',
        importance: Importance.high,
        priority: Priority.high,
        showProgress: true,
        maxProgress: 100,
      );
      const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
      );
      await LocalNotification.flutterLocalNotificationsPlugin.show(
        0,
        'News Notification',
        'Uploading...',
        notificationDetails,
      );

      // Check if it's a video file
      if (newsPath.endsWith('.mp4') ||
          newsPath.endsWith('.mov') ||
          newsPath.endsWith('.avi')) {
        final MediaInfo? compressedVideo = await VideoCompress.compressVideo(
          newsPath,
          quality: VideoQuality.LowQuality,
          deleteOrigin: false,
        );

        if (compressedVideo == null || compressedVideo.file == null) {
          throw Exception('Failed to compress video');
        }

        file = compressedVideo.file!;
        fileName = file.uri.pathSegments.last;
      } else {
        // Otherwise, it's an image file
        final List<int>? compressedImage =
            await FlutterImageCompress.compressWithFile(
          newsPath,
          quality: 85,
        );

        if (compressedImage == null) {
          throw Exception('Failed to compress image');
        }

        file = File('${file.parent.path}/compressed_$fileName')
          ..writeAsBytesSync(compressedImage);
      }

      final Reference storageRef =
          FirebaseStorage.instance.ref().child('ElErinatNews/$fileName');
      UploadTask uploadTask = storageRef.putFile(file);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) async {
        final double progress =
            (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
        final AndroidNotificationDetails updatedAndroidNotificationDetails =
            AndroidNotificationDetails(
          'upload_channel',
          'Upload Progress',
          channelDescription: 'Shows the progress of file uploads',
          importance: Importance.high,
          priority: Priority.high,
          showProgress: true,
          maxProgress: 100,
          progress: progress.toInt(),
        );
        final NotificationDetails updatedNotificationDetails =
            NotificationDetails(android: updatedAndroidNotificationDetails);
        await LocalNotification.flutterLocalNotificationsPlugin.show(
          0,
          'News Notification',
          'Uploading... ${(progress).toStringAsFixed(0)}%',
          updatedNotificationDetails,
        );
      });

      await uploadTask;
      downloadUrl = await storageRef.getDownloadURL();
      print(downloadUrl);
      uploadImageAndVideoModel.url = downloadUrl;

      print("url for files is${uploadImageAndVideoModel.url}");

      // Show completion notification
      await LocalNotification.flutterLocalNotificationsPlugin.show(
        0,
        'News Notification',
        'Upload complete!',
        notificationDetails,
      );

      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload news file: $e');
    }
  }

  //
  //!  upload Book to fireStore
  //

  Future<void> uploadNewsVedioAndImagetofirestore({
    required UploadImageAndVideoModel uploadImageAndVideoModel,
  }) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    final String formattedDate = formatter.format(DateTime.now());

    final newsData = UploadImageAndVideoModel(
      id: uploadImageAndVideoModel.id,
      uID: FirebaseAuth.instance.currentUser!.uid,
      url: uploadImageAndVideoModel.url,
      type: uploadImageAndVideoModel.type,
      path: uploadImageAndVideoModel.path,
      newsTitle: uploadImageAndVideoModel.newsTitle,
      newsSubTitle: uploadImageAndVideoModel.newsSubTitle,
      createdAt: formattedDate,
    ).toMap();

    final DocumentReference docRef =
        FirebaseFirestore.instance.collection('NewsFromAdmin').doc();
    await docRef.set(newsData);
  }

  //
  //!  get news from fireStore
  //

  Future<List<UploadImageAndVideoModel>> getNews() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('NewsFromAdmin').get();
    return querySnapshot.docs.map((doc) {
      return UploadImageAndVideoModel.fromMap(doc.data());
    }).toList();
  }

  //
  //!  upload  familt Tree pdf to storage
  //

  Future<void> uploadFamilyTreePdftOnStorage({
    required String pdfPath,
    required UploadTreeModel uploadTreeModel,
  }) async {
    final pdfFile = File(pdfPath);

    final pdfName = pdfFile.uri.pathSegments.last;

    try {
      // Upload PDF to Firebase Storage
      final pdfStorageRef = storage.ref(treeName).child('pdfs/$pdfName');
      final pdfUploadTask = await pdfStorageRef.putFile(pdfFile);
      final pdfUrl = await pdfUploadTask.ref.getDownloadURL();

      // Update uploadTreeModel with the obtained pdfUrl
      uploadTreeModel.pdfUrl = pdfUrl;
    } catch (e) {
      print('Error uploading PDF: $e');
      throw Exception('Failed to upload PDF');
    }
  }

  //
  //!  upload family Tree to from firestore
  //

  Future<void> saveTreeDataToFirestore(UploadTreeModel uploadTreeModel) async {
    final docRef = firestore.collection('FamilyTree').doc();
    final treeData = UploadTreeModel(
      id: uploadTreeModel.id,
      uID: FirebaseAuth.instance.currentUser!.uid,
      familyLineage: uploadTreeModel.familyLineage,
      familyName: uploadTreeModel.familyName,
      pdfName: uploadTreeModel.pdfName,
      pdfUrl: uploadTreeModel.pdfUrl,
      pdfPath: uploadTreeModel.pdfPath,
    ).toRemoteMap();

    await docRef.set(treeData);
  }

  //
  //!  u[pdate] family tree data in fireStore
  //

  Future<void> updateTreeDataInFirestore(
      UploadTreeModel updatedTree, int id) async {
    try {
      // Construct a map with only the fields that need to be updated
      Map<String, dynamic> updatedFields = {};

      if (updatedTree.familyName != null) {
        updatedFields['familyName'] = updatedTree.familyName;
      }

      if (updatedTree.familyLineage != null) {
        updatedFields['familyLineage'] = updatedTree.familyLineage;
      }

      if (updatedTree.pdfUrl != null) {
        updatedFields['pdfUrl'] = updatedTree.pdfUrl;
      }
      if (updatedTree.pdfName != null) {
        updatedFields['pdfName'] = updatedTree.pdfName;
      }

      // Add other fields to be updated similarly

      final querySnapshot = await firestore
          .collection('FamilyTree')
          .where('id', isEqualTo: id)
          .get();

      // Check if any documents were found
      if (querySnapshot.docs.isNotEmpty) {
        final docRef = querySnapshot.docs.first.reference;
        await docRef.update(updatedFields);
      } else {
        // Handle case where no document with matching id was found
        print('No document found with id: $id in Firestore');
        throw Exception('Document not found in Firestore');
      }
    } catch (e) {
      print('Error updating document in Firestore: $e');
      throw Exception('Failed to update document in Firestore');
    }
  }

  //
  //!  get family tree  data from fireStore
  //
  Future<List<UploadTreeModel>> getAllTrees() async {
    final querySnapshot = await firestore.collection('FamilyTree').get();
    return querySnapshot.docs.map((doc) {
      return UploadTreeModel.fromRemoteMap(doc.data());
    }).toList();
  }

  //
  //!  get  Auditor  family tree  from fireStore
  //

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
