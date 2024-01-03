import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // Mendapatkan informasi pengguna saat ini
  User? get currentUser => _auth.currentUser;

  // Metode untuk masuk dengan Google
  Future<void> userSignInGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // Metode untuk masuk dengan Facebook
  Future<void> userSignInFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final AuthCredential credential = FacebookAuthProvider.credential(
        loginResult.accessToken!.token,
      );

      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // Metode untuk mendeteksi perubahan status otentikasi
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
