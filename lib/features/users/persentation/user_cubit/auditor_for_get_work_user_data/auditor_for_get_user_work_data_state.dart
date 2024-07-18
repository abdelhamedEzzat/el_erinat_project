part of 'auditor_for_get_user_work_data_cubit.dart';

sealed class AuditorForGetUserWorkDataState extends Equatable {
  const AuditorForGetUserWorkDataState();

  @override
  List<Object> get props => [];
}

final class AuditorForGetUserWorkDataInitial
    extends AuditorForGetUserWorkDataState {}

final class WorkPersonalDetailsForAuditorLoading
    extends AuditorForGetUserWorkDataState {}

final class WorkPersonalDetailsForAuditorError
    extends AuditorForGetUserWorkDataState {
  final String failure;

  const WorkPersonalDetailsForAuditorError({required this.failure});
}

class WorkPersonalDetailsForAuditorLoaded
    extends AuditorForGetUserWorkDataState {
  final List<WorkModel> users;

  const WorkPersonalDetailsForAuditorLoaded(this.users);
}
