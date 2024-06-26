import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';
import 'package:el_erinat/features/users/data/model/suggetion_model.dart';
import 'package:el_erinat/features/users/data/repo/user_repo_impelmentation.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_local_data_source.dart';
import 'package:el_erinat/features/users/data/sorce_data/user_remote_data_source.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/suggestions_and_vote/vote_screen/animated_vote_container.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/suggestions_and_vote/vote_screen/vote_number_and_date.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/suggestions_and_vote/vote_screen/vote_title.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqflite/sqflite.dart';

class VoteScreen extends StatefulWidget {
  const VoteScreen({Key? key}) : super(key: key);

  @override
  State<VoteScreen> createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {
  int vote1Count = 0;
  int vote2Count = 0;
  int vote3Count = 0;

  Future<int> _getTotalUsers() async {
    var users = await FirebaseFirestore.instance.collection('users').get();
    return users.docs.length;
  }

  Future<int> _getTotalVotes() async {
    var votes = await FirebaseFirestore.instance.collection('votes').get();
    return votes.docs.length;
  }

  Future<bool> _hasUserVoted(String userId) async {
    var votes = await FirebaseFirestore.instance
        .collection('votes')
        .where('userId', isEqualTo: userId)
        .get();
    return votes.docs.isNotEmpty;
  }

  Future<void> _castVote(String userId, String voteOption) async {
    await FirebaseFirestore.instance.collection('votes').add({
      'userId': userId,
      'voteOption': voteOption,
      'timestamp': FieldValue.serverTimestamp(),
    });
    Database db = await LocalDatabaseHelper.instance.database;
    // Update vote counts locally
    if (voteOption == 'choice1') {
      await db.rawUpdate(
          'UPDATE userSuggetion SET vote1 = vote1 + 1 WHERE uID = ?', [userId]);
      setState(() {
        vote1Count++;
      });
    } else if (voteOption == 'choice2') {
      await db.rawUpdate(
          'UPDATE userSuggetion SET vote2 = vote2 + 1 WHERE uID = ?', [userId]);
      setState(() {
        vote2Count++;
      });
    } else if (voteOption == 'choice3') {
      await db.rawUpdate(
          'UPDATE userSuggetion SET vote3 = vote3 + 1 WHERE uID = ?', [userId]);
      setState(() {
        vote3Count++;
      });
    }

    // Trigger UI update after casting vote
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    UserRepoImplementation userRepoImplementation = UserRepoImplementation(
      localDatabaseHelper: LocalDatabaseHelper(),
      userRemoteDataSource: UserRemoteDataSource(),
    );

    return BackGroundAndAppBarAndDaynamicBody(
        alignmentTitle: Alignment.center,
        titleName: MStrings.voteChoise,
        yourBodyOfScreen: Positioned.fill(
          child: SingleChildScrollView(
            child: FutureBuilder<List<SuggetionModel>>(
              future: userRepoImplementation.getVotedToUser(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<SuggetionModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      SuggetionModel suggetionModel = snapshot.data![index];
                      vote1Count = suggetionModel.vote1 ?? 0;
                      vote2Count = suggetionModel.vote2 ?? 0;
                      vote3Count = suggetionModel.vote3 ?? 0;
                      return FutureBuilder<int>(
                        future: _getTotalUsers(),
                        builder: (context, userSnapshot) {
                          if (userSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (userSnapshot.hasError) {
                            return Center(
                                child: Text(userSnapshot.error.toString()));
                          } else if (userSnapshot.hasData) {
                            int totalUsers = userSnapshot.data!;
                            return FutureBuilder<int>(
                              future: _getTotalVotes(),
                              builder: (context, votesSnapshot) {
                                if (votesSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (votesSnapshot.hasError) {
                                  return Center(
                                      child:
                                          Text(votesSnapshot.error.toString()));
                                } else if (votesSnapshot.hasData) {
                                  int totalVotes = votesSnapshot.data!;
                                  double vote1Percentage = totalVotes > 0
                                      ? (vote1Count / totalVotes) * 100
                                      : 0;
                                  double vote2Percentage = totalVotes > 0
                                      ? (vote2Count / totalVotes) * 100
                                      : 0;
                                  double vote3Percentage = totalVotes > 0
                                      ? (vote3Count / totalVotes) * 100
                                      : 0;

                                  bool canVote = totalVotes < totalUsers;

                                  return FutureBuilder<bool>(
                                    future: _hasUserVoted(
                                        suggetionModel.uID.toString()),
                                    builder: (context, voteSnapshot) {
                                      if (voteSnapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      } else if (voteSnapshot.hasError) {
                                        return Center(
                                            child: Text(
                                                voteSnapshot.error.toString()));
                                      } else if (voteSnapshot.hasData) {
                                        bool hasVoted = voteSnapshot.data!;
                                        return Container(
                                          padding: EdgeInsets.all(20.w),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                  color: ColorManger.logoColor
                                                      .withOpacity(0.8),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8.h)),
                                                ),
                                                padding: EdgeInsets.all(25.h),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    VoteTitle(
                                                      title: suggetionModel
                                                          .suggetionTitle
                                                          .toString(),
                                                      subtitle: suggetionModel
                                                          .suggetionDescription
                                                          .toString(),
                                                    ),
                                                    SizedBox(height: 15.h),
                                                    AnimatedVoteContainer(
                                                      percentage:
                                                          vote1Percentage,
                                                      onTap: () async {
                                                        if (canVote &&
                                                            !hasVoted) {
                                                          await _castVote(
                                                              suggetionModel.uID
                                                                  .toString(),
                                                              'choice1');
                                                        }
                                                      },
                                                      textOfVote: suggetionModel
                                                          .firstChoise,
                                                      isEnabled:
                                                          canVote && !hasVoted,
                                                    ),
                                                    SizedBox(height: 15.h),
                                                    AnimatedVoteContainer(
                                                      percentage:
                                                          vote2Percentage,
                                                      onTap: () async {
                                                        if (canVote &&
                                                            !hasVoted) {
                                                          await _castVote(
                                                              suggetionModel.uID
                                                                  .toString(),
                                                              'choice2');
                                                        }
                                                      },
                                                      textOfVote: suggetionModel
                                                          .secoundChoise,
                                                      isEnabled:
                                                          canVote && !hasVoted,
                                                    ),
                                                    SizedBox(height: 15.h),
                                                    suggetionModel
                                                                .thirdChoise !=
                                                            null
                                                        ? AnimatedVoteContainer(
                                                            percentage:
                                                                vote3Percentage,
                                                            onTap: () async {
                                                              if (canVote &&
                                                                  !hasVoted) {
                                                                await _castVote(
                                                                    suggetionModel
                                                                        .uID
                                                                        .toString(),
                                                                    'choice3');
                                                              }
                                                            },
                                                            textOfVote:
                                                                suggetionModel
                                                                    .thirdChoise!,
                                                            isEnabled:
                                                                canVote &&
                                                                    !hasVoted,
                                                          )
                                                        : Container(),
                                                    VoteNumberAndDate(
                                                      voteNumber: totalVotes,
                                                      date: suggetionModel
                                                          .createdAt
                                                          .toString(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return Container(
                                          alignment: Alignment.center,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: Text("No data available"),
                                        );
                                      }
                                    },
                                  );
                                } else {
                                  return Container(
                                    alignment: Alignment.center,
                                    height: MediaQuery.of(context).size.height,
                                    child: Text("No data available"),
                                  );
                                }
                              },
                            );
                          } else {
                            return Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height,
                              child: Text("No data available"),
                            );
                          }
                        },
                      );
                    },
                  );
                } else {
                  return Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height,
                    child: Text("No data available"),
                  );
                }
              },
            ),
          ),
        ));
  }
}
