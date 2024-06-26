part of 'google_auth_cubit.dart';

@immutable
sealed class GoogleAuthState {}

final class GoogleAuthInitial extends GoogleAuthState {}

final class GoogleAuthLoading extends GoogleAuthState {}

final class GoogleAuthSuccess extends GoogleAuthState {
  final User user;

  GoogleAuthSuccess(this.user);
}

final class GoogleAuthfaild extends GoogleAuthState {
  final String errMassge;

  GoogleAuthfaild({required this.errMassge});
}
