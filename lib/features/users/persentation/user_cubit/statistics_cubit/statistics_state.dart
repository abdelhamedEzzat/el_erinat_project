part of 'statistics_cubit.dart';

sealed class StatisticsState extends Equatable {
  const StatisticsState();

  @override
  List<Object> get props => [];
}

final class StatisticsInitial extends StatisticsState {}

class StatisticsUpdated extends StatisticsState {
  final int totalDead;
  final int totalMales;
  final int totalFamilies;

  const StatisticsUpdated({
    required this.totalDead,
    required this.totalMales,
    required this.totalFamilies,
  });

  @override
  List<Object> get props => [totalDead, totalMales, totalFamilies];
}
