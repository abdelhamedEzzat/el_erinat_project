import 'package:el_erinat/features/users/data/model/user_model.dart';
import 'package:el_erinat/features/users/domain/user_layer/entityes/analitics.dart';
import 'package:el_erinat/features/users/domain/user_layer/repo/user_repo.Dart';
import 'package:el_erinat/features/users/domain/user_layer/use_cases/add_details_users.dart';
import 'package:el_erinat/features/users/persentation/user_cubit/personal_details_cubit/personal_details_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalDetailsCubit extends Cubit<PersonalDetailsState> {
  PersonalDetailsCubit({required this.userRepo})
      : super(PersonalDetailsInitial());

  String uid = FirebaseAuth.instance.currentUser!.uid;
  final UserRepo userRepo;

  Future<void> saveDataForUser(
      UserModel user, String role, String status) async {
    emit(PersonalDetailsLoading());
    final addUserUseCase = AddUser(userRepo: userRepo);
    final result = await addUserUseCase.call(user, role, status);
    result.fold(
      (failure) {
        emit(PersonalDetailsError(failure: failure.message));
      },
      (user) {
        emit(PersonalDetailsSuccess(user: user));
      },
    );
  }

  Future<void> updateRoleToUser(UserModel user, String role) async {
    try {
      emit(UpdateRoleDetailsLoading());
      final addUserUseCase = UpdateRoleForAnyUser(userRepo);
      await addUserUseCase.call(role, user);
      final currentState = state;
      if (currentState is PersonalDetailsLoaded) {
        final updatedUsers = currentState.users.map((u) {
          return u.id == user.id ? u.copyWith(role: role) : u;
        }).toList();
        emit(PersonalDetailsLoaded(updatedUsers));
      } else {
        emit(PersonalDetailsError(failure: "Unexpected state"));
      }
    } catch (e) {
      emit(PersonalDetailsError(failure: e.toString()));
    }
  }

  Future<void> updateDataForUser(UserModel user) async {
    emit(PersonalDetailsLoading());
    final addUserUseCase = UpdateUser(userRepo: userRepo);
    final result = await addUserUseCase.call(user);
    result.fold(
      (failure) {
        emit(PersonalDetailsError(failure: failure.message));
      },
      (user) {
        emit(PersonalDetailsSuccess(user: user));
      },
    );
  }

  Future<void> fetchUsersbYId() async {
    try {
      emit(PersonalDetailsLoading());
      final users = await userRepo.getPersonalUsers();
      emit(PersonalDetailsLoaded(users));
    } catch (e) {
      emit(PersonalDetailsError(failure: e.toString()));
    }
  }

  Future<void> fetchUsersToUditorbYUId(String uid) async {
    try {
      emit(PersonalDetailsForAuditorLoading());
      final users = await userRepo.getPersonalUsersDataByUidToAuditor(uid);
      emit(PersonalDetailsForAuditorSuccess(users: users));
    } catch (e) {
      emit(PersonalDetailsError(failure: e.toString()));
    }
  }

  Future<void> fetchWaitingUsers() async {
    try {
      emit(WattingPersonalDetailsLoading());
      final users = await userRepo.getWattingUsers();

      if (users.isNotEmpty) {
        emit(WattingPersonalDetailsSuccess(users: users));
      } else {
        emit(WattingPersonalDetailsError(failure: "No waiting users found"));
      }
    } catch (e) {
      emit(WattingPersonalDetailsError(failure: e.toString()));
    }
  }

  Future<void> fetchAcceptedUsers() async {
    try {
      emit(AcceptPersonalDetailsLoading());
      final users = await userRepo.getAcceptedUsers();
      if (users.isNotEmpty) {
        emit(AcceptPersonalDetailsSuccess(users: users));
      } else {
        emit(AcceptPersonalDetailsError(failure: "No accepted users found"));
      }
    } catch (e) {
      print("----------------------------------${e.toString()}");
      emit(AcceptPersonalDetailsError(failure: e.toString()));
    }
  }

  Future<void> updateStatusOfUsers(int id, String newStatus) async {
    try {
      emit(UpdateStatusLoading());
      await userRepo.updateStutsOfUser(id, newStatus);
      emit(UpdateStatusSuccess());
    } catch (e) {
      emit(UpdateStatusError(failure: e.toString()));
    }
  }

  Future<void> deleteUserWhenUnAccepted(String uID, UserModel user) async {
    try {
      emit(DeleteUnAcceptedUserLoading());
      await userRepo.deleteUserWhenUnAccepted(uID, user);
      emit(DeleteUnAcceptedUserSuccess());
    } catch (e) {
      emit(DeleteUnAcceptedUserError(failure: e.toString()));
    }
  }

  int personalInFamilies = 0;
  int allFamilies = 0;
  int totalMales = 0;
  int totalFemales = 0;
  int liveMale = 0;
  int totalLive = 0;
  int totalDead = 0;

  final Map<String, UserModel> _previousUserStates = {};

  void updateStatistics(UserModel newUser) async {
    emit(StatisticsUpdatedLoading());
    final previousUser = _previousUserStates[newUser.uID];
    if (previousUser == null) {
      // Fetch current statistics from the repository
      final currentStatistics = await userRepo.getStatistics();

      // Initialize with current statistics or default to 0
      personalInFamilies = currentStatistics.personalInFamilies ?? 0;
      totalMales = currentStatistics.totalMales ?? 0;
      totalFemales = currentStatistics.totalFemales ?? 0;
      liveMale = currentStatistics.liveMale ?? 0;
      totalLive = currentStatistics.totalLive ?? 0;
      totalDead = currentStatistics.totalDead ?? 0;
      allFamilies = currentStatistics.allFamilies ?? 0;

      // New user addition
      personalInFamilies++;
      if (newUser.gender == 'رجل') {
        totalMales++;
        liveMale++;
      } else {
        totalFemales++;
      }
      if (newUser.familyName != null) {
        allFamilies++;
      }
      updateLiveDeadCounts(newUser.fatherLiveORDead,
          newUser.grandfatherLiveORDead, newUser.greatGrandFatherLiveOrDead);

      // Store the updated user state
      _previousUserStates[newUser.uID.toString()] = newUser;
    } else {
      // Existing user update
      // Handle gender change
      if (previousUser.gender != newUser.gender) {
        if (previousUser.gender == 'رجل') {
          totalMales--;
          liveMale--;
          totalFemales++;
        } else {
          totalFemales--;
          totalMales++;
          liveMale++;
        }
      }

      // Update counts based on user data changes
      if (previousUser.fatherLiveORDead != newUser.fatherLiveORDead) {
        updateSingleLiveDeadCount(previousUser.fatherLiveORDead, -1);
        updateSingleLiveDeadCount(newUser.fatherLiveORDead, 1);
      }
      if (previousUser.grandfatherLiveORDead != newUser.grandfatherLiveORDead) {
        updateSingleLiveDeadCount(previousUser.grandfatherLiveORDead, -1);
        updateSingleLiveDeadCount(newUser.grandfatherLiveORDead, 1);
      }
      if (previousUser.greatGrandFatherLiveOrDead !=
          newUser.greatGrandFatherLiveOrDead) {
        updateSingleLiveDeadCount(previousUser.greatGrandFatherLiveOrDead, -1);
        updateSingleLiveDeadCount(newUser.greatGrandFatherLiveOrDead, 1);
      }

      // Handle familyName change
      if (previousUser.familyName != newUser.familyName) {
        if (previousUser.familyName == null && newUser.familyName != null) {
          allFamilies++;
        } else if (previousUser.familyName != null &&
            newUser.familyName == null) {
          allFamilies--;
        }
      }

      // Store the updated user state
      _previousUserStates[newUser.uID.toString()] = newUser;
    }

    // Ensure all values are non-negative
    personalInFamilies = personalInFamilies < 0 ? 0 : personalInFamilies;
    totalMales = totalMales < 0 ? 0 : totalMales;
    totalFemales = totalFemales < 0 ? 0 : totalFemales;
    liveMale = liveMale < 0 ? 0 : liveMale;
    totalLive = totalLive < 0 ? 0 : totalLive;
    totalDead = totalDead < 0 ? 0 : totalDead;
    allFamilies = allFamilies < 0 ? 0 : allFamilies;

    // Emit updated statistics
    emit(StatisticsUpdated(
      totalMales: totalMales,
      totalDead: totalDead,
      totalFamilies: totalFemales,
      liveMale: liveMale,
      totalLive: totalLive,
      personalInFamilies: personalInFamilies,
      allFamilies: allFamilies,
    ));

    // Create updated statistics object
    final statistics = Statistics(
      allFamilies: allFamilies,
      personalInFamilies: personalInFamilies,
      totalDead: totalDead,
      totalFemales: totalFemales,
      totalLive: totalLive,
      totalMales: totalMales,
      liveMale: liveMale,
    );

    // Store the updated statistics
    await userRepo.saveStatistics(statistics);
  }

  void updateLiveDeadCounts(String? fatherLiveORDead,
      String? grandfatherLiveORDead, String? greatGrandFatherLiveOrDead) {
    updateSingleLiveDeadCount(fatherLiveORDead, 1);
    updateSingleLiveDeadCount(grandfatherLiveORDead, 1);
    updateSingleLiveDeadCount(greatGrandFatherLiveOrDead, 1);
  }

  void updateSingleLiveDeadCount(String? status, int change) {
    if (status == 'متوفي') {
      totalDead += change;
    } else if (status == 'علي قيد الحياة') {
      totalLive += change;
    }
  }

  Future<void> fetchStatistics() async {
    try {
      emit(GetStatisticsLoading());
      final statistics = await userRepo.getStatistics();
      emit(GetStatisticsLoaded(statistics: statistics));
    } catch (e) {
      emit(GetStatisticsError(failure: e.toString()));
    }
  }
}

//  else  {
//       // Existing user update
//       // Handle gender change
//       if (previousUser.gender != newUser.gender) {
//         if (previousUser.gender == 'رجل') {
//           totalMales--;
//           totalFemailes++;
//         } else {
//           totalFemailes--;
//           totalMales++;
//         }
//       }

//       // Update counts based on user data changes
//       if (previousUser.fatherLiveORDead != newUser.fatherLiveORDead ||
//           previousUser.grandfatherLiveORDead != newUser.grandfatherLiveORDead ||
//           previousUser.greatGrandFatherLiveOrDead !=
//               newUser.greatGrandFatherLiveOrDead) {
//         updateLiveDeadCounts(newUser.fatherLiveORDead,
//             newUser.grandfatherLiveORDead, newUser.greatGrandFatherLiveOrDead);
//       }
//       if (newUser.gender == 'رجل' && previousUser.gender != newUser.gender) {
//         liveMale++;
//         totalFemailes--;
//       } else if (newUser.gender != 'رجل' &&
//           previousUser.gender != newUser.gender) {
//         liveMale--;
//         totalFemailes++;
//       }
//       // Handle familyName change
//       if (previousUser.familyName != newUser.familyName) {
//         if (previousUser.familyName == null) {
//           allFamilies++;
//         }
//       }

//       // Store the updated user state
//       _previousUserStates[newUser.uID.toString()] = newUser;
//     }
