import 'package:bloc/bloc.dart';
import 'package:el_erinat/features/users/data/model/user_problems_model.dart';
import 'package:el_erinat/features/users/domain/user_layer/repo/user_repo.Dart';
import 'package:el_erinat/features/users/domain/user_layer/use_cases/user_problems_use_cases.dart';
import 'package:equatable/equatable.dart';

part 'problems_state.dart';

class ProblemsCubit extends Cubit<ProblemsState> {
  ProblemsCubit(this.userRepo) : super(ProblemsInitial());
  UserRepo userRepo;
  Future<void> uploadproblems({required UserProblemsModel problems}) async {
    emit(UploadProblemsLoading());

    final addUserUseCase = UploadProblemsImageUser(userRepo: userRepo);
    final result = await addUserUseCase.call(problems);

    result.fold(
      (failure) {
        emit(UploadProblemsError(failure: failure.message));
        print('Error adding user: ${failure.message}');
      },
      (user) async {
        emit(UploadProblemsSuccess(
            userProblemsModel: user as UserProblemsModel));
        print(
            'User added successfully to Firebase and local database: ${user.createdAt}');
      },
    );
  }

  Future<void> getAllProblemsForUserByUID() async {
    UserProblemsModel userProblemsModel = UserProblemsModel();
    try {
      emit(GetProblemsUserLoading());

      final newsList =
          await userRepo.getProblemsOfUser(userProblemsModel.uID.toString());
      if (newsList.isNotEmpty) {
        emit(GetProblemsUserSuccess(news: newsList));
      } else {
        emit(const GetProblemsUserError(failure: 'No problems found'));
      }
    } catch (e) {
      emit(GetProblemsUserError(failure: e.toString()));
      print(e.toString());
    }
  }

  //!
  List<UserProblemsModel> problemsDataList = [];
  void addSuggetionItem(UserProblemsModel problem) {
    problemsDataList.add(problem);
    emit(GetProblemsSuccess(news: problemsDataList));
  }

  Future<void> getWattingproblemsForAuditors() async {
    try {
      emit(GetProblemsLoading());
      final newsList = await userRepo.getWattingProblemsForAuditor();
      if (newsList.isNotEmpty) {
        problemsDataList = newsList;
        emit(GetProblemsSuccess(news: newsList));
      } else {
        emit(const GetProblemsError(failure: 'No problems found'));
      }
    } catch (e) {
      emit(GetProblemsError(failure: e.toString()));
      print(e.toString());
    }
  }

  Future<void> getFinishedProblemForAuditor() async {
    try {
      emit(GetFinishedProblemsLoading());
      final newsList = await userRepo.getFinishedProblemsForAuditor();
      if (newsList.isNotEmpty) {
        problemsDataList = newsList;
        emit(GetFinishedProblemsSuccess(suggetion: newsList));
      } else {
        emit(const GetFinishedProblemsError(failure: 'No problems found'));
      }
    } catch (e) {
      emit(GetFinishedProblemsError(failure: e.toString()));
      print(e.toString());
    }
  }

  Future<void> updateProblemsStatus(
    int id,
    String newStatus,
  ) async {
    try {
      emit(UpdateProblemsLoading());
      await userRepo.updateFinishedProblemsToAuditor(id, newStatus);

      emit(const UpdateProblemsSuccess());
    } catch (e) {
      emit(UpdateProblemsError(failure: e.toString()));
      print(e.toString());
    }
  }
//   Future<void> updateSuggtions(
//     int id,
//     String newStatus,
//   ) async {
//     try {
//       emit(UpdateSuggestionLoading());
//       await userRepo.updateFinishedSuggetionsToAuditor(id, newStatus);

//       emit(const UpdateSuggestionSuccess());
//     } catch (e) {
//       emit(UpdateSuggestionError(failure: e.toString()));
//       print(e.toString());
//     }
//   }

//   List<SuggetionModel> getFinishedSuggetionList = [];
//   void addFinishedSuggetionItem(SuggetionModel suggetion) {
//     getFinishedSuggetionList.add(suggetion);
//     emit(GetSuggestionSuccess(news: getFinishedSuggetionList));
//   }

//   Future<void> getFinishedSuggetions() async {
//     try {
//       emit(GetFinishedSuggestionLoading());
//       final newsList = await userRepo.getFinishedSuggetionsToAuditor();
//       if (newsList.isNotEmpty) {
//         getFinishedSuggetionList = newsList;
//         emit(GetFinishedSuggestionSuccess(suggetion: newsList));
//       } else {
//         emit(const GetFinishedSuggestionError(
//             failure: 'No finished suggetion found'));
//       }
//     } catch (e) {
//       emit(GetFinishedSuggestionError(failure: e.toString()));
//       print(e.toString());
//     }
//   }
// }
}
