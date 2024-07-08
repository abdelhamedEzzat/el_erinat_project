import 'package:el_erinat/features/admin/data/model/upload_image_video_model.dart';
import 'package:el_erinat/features/admin/data/repo_admin/admin_repo_impelment.dart';
import 'package:el_erinat/features/admin/data/sorce_data_admin/admin_local_data_base_helper.dart';
import 'package:el_erinat/features/admin/data/sorce_data_admin/remote_data_base_helper.dart';
import 'package:flutter/material.dart';


AdminRepoImplementation adminRepoImplementation = AdminRepoImplementation( 
  adminLocalDatabaseHelper: AdminLocalDatabaseHelper(),
  adminRemoteDataBaseHelper: AdminRemoteDataBaseHelper(),
   

);
// class UploadScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//    AdminRemoteDataBaseHelper localDatabaseHelper = AdminRemoteDataBaseHelper();


//     return Scaffold(
//       appBar: AppBar(
//         title: Text('StreamBuilder with sqflite'),
//       ),
//       body: 
      
      
      
      
//    StreamBuilder<List<UploadImageAndVideoModel>>(
//   stream: adminRepoImplementation.newsStream,
//   builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return CircularProgressIndicator();
//     } else if (snapshot.hasError) {
//       return Text('Error: ${snapshot.error}');
//     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//       return Text('No news uploads found');
//     } else {
//       final newsUploads = snapshot.data;
//       return ListView.builder(
//         itemCount: newsUploads!.length,
//         itemBuilder: (context, index) {
//           final news = newsUploads[index];
//           return ListTile(
//             title: Text(news.newsTitle.toString()),
//             subtitle: Text(news.newsSubTitle.toString()),
//           );
//         },
//       );
//     }
//   },
// ),
// floatingActionButton: FloatingActionButton(
//   onPressed: () {
//     // Add a new item
//     adminRepoImplementation.uploadAndSavenews(uploadImageAndVideoModel: 
//       UploadImageAndVideoModel(
//         id:4,
//         createdAt: "2023-05-01 00:00:00",
//         newsSubTitle: "newsSubTitle",
//         newsTitle: "newsTitle",
//         path: "path",
//         type: "type",
//         uID: "uID",
//         url: "url",
//       ),
//     );
//   },
//   child: Icon(Icons.add),
// ),
    // );
  // }
// }