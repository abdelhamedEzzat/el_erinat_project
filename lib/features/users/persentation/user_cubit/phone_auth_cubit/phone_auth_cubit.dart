import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  PhoneAuthCubit() : super(PhoneAuthInitial());

  late String verificationId;

  String? phone;
  int? _resendToken;
  FirebaseAuth auth = FirebaseAuth.instance;

  //! verificationPhoneNumber main function
  Future<void> verificationPhoneNumber(String phoneNumber) async {
    if (phoneNumber.isEmpty) {
      emit(PhoneAuthFailed(errorMsg: 'رقم الهاتف مطلوب'));
      return;
    }

    phone = phoneNumber;
    emit(PhoneAuthLoading());
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      forceResendingToken: _resendToken,
      timeout: const Duration(seconds: 14),
      verificationCompleted: verificationCompleted,
      verificationFailed: phoneVerificationFailed,
      codeSent: codeSend,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  //! verificationCompleted
  Future<void> verificationCompleted(PhoneAuthCredential credential) async {
    await signIn(credential);
  }

  //! phoneVerificationFailed
  void phoneVerificationFailed(FirebaseAuthException error) {
    emit(PhoneAuthFailed(errorMsg: error.message.toString()));
  }

  //! signIn
  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      emit(PhoneAuthLoading());
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(PhoneCodeVerifiedState());
    } catch (error) {
      emit(PhoneAuthFailed(errorMsg: error.toString()));
    }
  }

  void signInWithPhone(AuthCredential credential) async {
    try {
      UserCredential userCredential =
          await auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        emit(AuthLoggedInState(userCredential.user!));
      }
    } on FirebaseAuthException catch (ex) {
      emit(PhoneAuthFailed(errorMsg: ex.message.toString()));
    }
  }

  //! codeSend
  Future<void> codeSend(String verificationId, int? forceResendingToken) async {
    this.verificationId = verificationId;
    _resendToken = forceResendingToken;
    emit(PhoneCodeSentState());
  }

  //! submitOTP
  Future<void> verifyOTP(String otpCode) async {
    try {
      emit(PhoneAuthLoading());
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otpCode);

      await signIn(credential);
      emit(PhoneCodeVerifiedState());
    } on FirebaseAuthException catch (e) {
      emit(PhoneAuthFailed(errorMsg: e.message.toString()));
    }
  }

  //! logOut
  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  //! codeAutoRetrievalTimeout
  void codeAutoRetrievalTimeout(String verificationId) {
    // ignore: avoid_print
    print(codeAutoRetrievalTimeout);
  }
}
