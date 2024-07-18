import 'package:bloc/bloc.dart';
import 'package:el_erinat/features/users/data/model/work_user_model.dart';
import 'package:el_erinat/features/users/domain/user_layer/repo/user_repo.Dart';
import 'package:equatable/equatable.dart';

part 'auditor_for_get_user_work_data_state.dart';

class AuditorForGetUserWorkDataCubit
    extends Cubit<AuditorForGetUserWorkDataState> {
  AuditorForGetUserWorkDataCubit(this.userRepo)
      : super(AuditorForGetUserWorkDataInitial());
  final UserRepo userRepo;
  Future<void> fetchAllPersonalUsersinfoByIDForAuditor(String uid) async {
    try {
      emit(WorkPersonalDetailsForAuditorLoading());

      final users = await userRepo.fetchWorkUsersinfoByID(uid);

      emit(WorkPersonalDetailsForAuditorLoaded(users));
    } catch (e) {
      emit(WorkPersonalDetailsForAuditorError(failure: e.toString()));
    }
  }
}
