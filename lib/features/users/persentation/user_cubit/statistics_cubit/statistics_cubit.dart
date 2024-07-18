import 'package:bloc/bloc.dart';
import 'package:el_erinat/features/users/data/model/user_model.dart';
import 'package:equatable/equatable.dart';

part 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  StatisticsCubit() : super(StatisticsInitial());

  void updateStatistics(UserModel user) {
    if (state is StatisticsUpdated) {
      final currentState = state as StatisticsUpdated;

      int totalDead = currentState.totalDead;
      int totalMales = currentState.totalMales;
      int totalFamilies = currentState.totalFamilies;

      if (user.fatherLiveORDead == 'Deceased') totalDead++;
      if (user.gender == 'Male') totalMales++;
      totalFamilies++;

      emit(StatisticsUpdated(
          totalDead: totalDead,
          totalMales: totalMales,
          totalFamilies: totalFamilies));
    } else {
      int totalDead = 0;
      int totalMales = 0;
      int totalFamilies = 1; // Assuming this is the first family being added

      if (user.fatherLiveORDead == 'Deceased') totalDead++;
      if (user.gender == 'Male') totalMales++;

      emit(StatisticsUpdated(
          totalDead: totalDead,
          totalMales: totalMales,
          totalFamilies: totalFamilies));
    }
  }
}
