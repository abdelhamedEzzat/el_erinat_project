import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  PhoneAuthCubit() : super(PhoneAuthInitial());

  late String verificationId;

  FirebaseAuth auth = FirebaseAuth.instance;

  //! verificationPhoneNumber main function
  Future verificationPhoneNumber(String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: phoneVerificationFailed,
      codeSent: codeSend,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

//! verificationCompleted

  verificationCompleted(PhoneAuthCredential credential) async {
    await signIn(credential);
  }

//! phoneVerificationFailed

  void phoneVerificationFailed(FirebaseAuthException error) {
    emit(PhoneAuthFailed(errorMsg: error.toString()));
  }

//! signIn

  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(PhoneAuthCompleted());
    } catch (error) {
      emit(PhoneAuthFailed(errorMsg: error.toString()));
    }
  }

//! codeSend

  Future<void> codeSend(
    String verificationId,
    int? forceResendingToken,
  ) async {
    this.verificationId = verificationId;
    emit(PhoneAuthCompleted());
  }

//! submitOTP

  Future<void> submitOTP(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpCode);

    await signIn(credential);
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
