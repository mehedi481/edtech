import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  const AuthRepository(this._firebaseAuth);
  final FirebaseAuth _firebaseAuth;

  Stream<User?> get authStateChange => _firebaseAuth.idTokenChanges();

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'An error occurred during sign-in.';
    }
  }

  Future<User?> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'An error occurred during sign-up.';
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
