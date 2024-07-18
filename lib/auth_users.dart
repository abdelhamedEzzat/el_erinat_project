import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/features/admin/persentation/screens/admin_home_screen.dart';
import 'package:el_erinat/features/auditor_team/persentation/screen/auditor_team_home_screen.dart';
import 'package:el_erinat/features/users/persentation/screens/home/home_screen.dart';
import 'package:el_erinat/features/users/persentation/screens/register_screen/register_screen.dart';
import 'package:el_erinat/features/users/persentation/screens/splash_screen/splach_screen.dart';
import 'package:el_erinat/features/users/persentation/screens/user_details_screen/user_details_identaty.dart';
import 'package:el_erinat/features/users/persentation/screens/user_details_screen/user_details_screen.dart';
import 'package:el_erinat/features/users/persentation/screens/user_details_screen/work_user_detatils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthUsers extends StatelessWidget {
  const AuthUsers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        User? user = snapshot.data;
        User? users = FirebaseAuth.instance.currentUser;
        //   var status = Constanscollection.getUserStatus();
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Loading state
          return Center(
            child: CircularProgressIndicator(
              color: ColorManger.logoColor,
            ),
          );
        } else if (user != null && users != null) {
          print("==================================User sign in ");
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  // Loading user data
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (userSnapshot.hasData) {
                  // User data is available, check role
                  var userData =
                      userSnapshot.data!.data() as Map<String, dynamic>;
                  var personalDetails =
                      userData['personalDetails'] as Map<String, dynamic>?;
                  var workDetails =
                      userData['workDetails'] as Map<String, dynamic>?;
                  var identityImage =
                      userData['identityImage'] as Map<String, dynamic>?;

                  if (personalDetails == null) {
                    return const UserDitailsScreen();
                  } else if (workDetails == null) {
                    return const WorkUserDetails();
                  } else if (identityImage == null) {
                    return const UserDetailsIdentaty();
                  } else if (userSnapshot.data == null) {
                    return const RegisterScreen();
                  } else {
                    var role = personalDetails?['role'] as String?;
                    if (role == "مشرف") {
                      return const AuditorTeamHomeScreen();
                    } else if (role == "مسؤول") {
                      return const AdminHomeScreen();
                    } else {
                      return const HomeScreen();
                    }
                  }
                } else {
                  return const RegisterScreen();
                }
              });
        } else if (user == null && users == null) {
          return const SplachScreen();
        } else {
          print("==================================User sign out ");
          return const RegisterScreen();
        }
      },
    );
  }
}
      // else if (user == null && users == null){
      //         return const SplachScreen();
      //   }
      
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