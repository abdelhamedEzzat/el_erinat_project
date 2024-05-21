part of 'phone_auth_cubit.dart';

@immutable
sealed class PhoneAuthState {}

final class PhoneAuthInitial extends PhoneAuthState {}

final class PhoneAuthCompleted extends PhoneAuthState {}

final class PhoneAuthFailed extends PhoneAuthState {
  final String errorMsg;

  PhoneAuthFailed({required this.errorMsg});
}
