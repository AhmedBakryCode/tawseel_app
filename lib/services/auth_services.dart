import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerUser(String email, String password, String name, String address, String phone, String role) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String userId = _generateUserId();

      // Add user details to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userId,
        'name': name,
        'email': email,
        'address': address,
        'phone': phone,
        'role': role,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // Login user
  Future<UserCredential> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential; // Return the UserCredential
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }
  // Generate dynamic user ID
  String _generateUserId() {
    return DateTime.now().millisecondsSinceEpoch.toString().substring(5);
  }


  Future<void> sendOtp(String phoneNumber, void Function(PhoneAuthCredential) onVerificationCompleted, void Function(FirebaseAuthException) onVerificationFailed, void Function(String verificationId, int? resendToken) onCodeSent) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: onVerificationCompleted,
      verificationFailed: onVerificationFailed,
      codeSent: onCodeSent, // Called when the OTP is sent
      codeAutoRetrievalTimeout: (String verificationId) {
        // Timeout after which the OTP can no longer be auto-retrieved
        print("Code auto retrieval timeout for verificationId: $verificationId");
      },
    );
  }


  Future<User?> verifyOtp(String verificationId, String otp) async {
    try {
      // Create the phone auth credential with the verificationId and OTP
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      // Sign in the user with the created credential
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print("Failed to verify OTP: $e");
      return null;
    }
  }

  // Update password method
  Future<void> updatePassword(String newPassword) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await user.updatePassword(newPassword);
    } else {
      throw 'No user signed in. Cannot update password.';
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
