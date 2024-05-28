part of 'save_get_featch_user_details_cubit.dart';

@immutable
sealed class SaveGetFeatchUserDetailsState {}

final class SaveGetFeatchUserDetailsInitial
    extends SaveGetFeatchUserDetailsState {}

final class SaveGetFeatchUserDetailsLoading
    extends SaveGetFeatchUserDetailsState {}

final class SaveGetFeatchUserDetailsError
    extends SaveGetFeatchUserDetailsState {
  final String failure;

  SaveGetFeatchUserDetailsError({required this.failure});
}

final class SaveGetFeatchUserDetailsSuccess
    extends SaveGetFeatchUserDetailsState {
  final AddDetailsUser user;

  SaveGetFeatchUserDetailsSuccess({required this.user});
}
