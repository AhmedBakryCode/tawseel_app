import 'package:firebase_auth/firebase_auth.dart';

class OTPService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to send OTP
  Future<void> sendOTP(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-verification of OTP
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        throw e; // Handle verification failure
      },
      codeSent: (String verificationId, int? resendToken) {
        // Store the verification ID for later use
        // You can use it to verify the OTP
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto retrieval timeout, you can handle here if needed
      },
    );
  }

  // Method to verify OTP
  Future<void> verifyOTP(String verificationId, String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );

    await _auth.signInWithCredential(credential);
  }
}
