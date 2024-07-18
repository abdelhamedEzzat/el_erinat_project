import 'package:bloc/bloc.dart';
import 'package:el_erinat/features/users/data/model/suggetion_model.dart';
import 'package:el_erinat/features/users/domain/user_layer/repo/user_repo.Dart';
import 'package:el_erinat/features/users/domain/user_layer/use_cases/suggetion_use_case.dart';
import 'package:equatable/equatable.dart';

part 'suggtions_and_vote_state.dart';

class SuggtionsAndVoteCubit extends Cubit<SuggtionsAndVoteState> {
  SuggtionsAndVoteCubit({required this.userRepo})
      : super(SuggtionsAndVoteInitial());
  final UserRepo userRepo;

  Future<void> uploadSuggetions(
      {required SuggetionModel suggtions, required String role}) async {
    emit(UploadSuggestionLoading());

    final addUserUseCase = InsertSuggetionUser(userRepo: userRepo);
    final result = await addUserUseCase.call(suggtions, role);

    result.fold(
      (failure) {
        emit(UploadSuggestionError(failure: failure.message));
        print('Error adding user: ${failure.message}');
      },
      (user) async {
        emit(UploadSuggestionSuccess(suggetionModel: user as SuggetionModel));
        print(
            'User added successfully to Firebase and local database: ${user.role}');
      },
    );
  }

  //!
  List<SuggetionModel> newsDataList = [];
  void addSuggetionItem(SuggetionModel suggetion) {
    newsDataList.add(suggetion);
    emit(GetSuggestionSuccess(news: newsDataList));
  }

  Future<void> getSuggetions() async {
    try {
      emit(GetSuggestionLoading());
      final newsList = await userRepo.getWattingSuggetionsToAuditor();
      if (newsList.isNotEmpty) {
        newsDataList = newsList;
        emit(GetSuggestionSuccess(news: newsList));
      } else {
        emit(const GetSuggestionError(failure: 'No suggetion found'));
      }
    } catch (e) {
      emit(GetSuggestionError(failure: e.toString()));
      print(e.toString());
    }
  }

  Future<void> updateSuggtions(
    int id,
    String newStatus,
  ) async {
    try {
      emit(UpdateSuggestionLoading());
      await userRepo.updateFinishedSuggetionsToAuditor(id, newStatus);

      emit(const UpdateSuggestionSuccess());
    } catch (e) {
      emit(UpdateSuggestionError(failure: e.toString()));
      print(e.toString());
    }
  }

  List<SuggetionModel> getFinishedSuggetionList = [];
  void addFinishedSuggetionItem(SuggetionModel suggetion) {
    getFinishedSuggetionList.add(suggetion);
    emit(GetSuggestionSuccess(news: getFinishedSuggetionList));
  }

  Future<void> getFinishedSuggetions() async {
    try {
      emit(GetFinishedSuggestionLoading());
      final newsList = await userRepo.getFinishedSuggetionsToAuditor();
      if (newsList.isNotEmpty) {
        getFinishedSuggetionList = newsList;
        emit(GetFinishedSuggestionSuccess(suggetion: newsList));
      } else {
        emit(const GetFinishedSuggestionError(
            failure: 'No finished suggetion found'));
      }
    } catch (e) {
      emit(GetFinishedSuggestionError(failure: e.toString()));
      print(e.toString());
    }
  }
}
