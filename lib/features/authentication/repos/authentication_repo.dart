import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get user {
    return _firebaseAuth.currentUser;
  }

  bool get isLoggedIn {
    return user != null;
  }

  Stream<User?> authStateChange() {
    return _firebaseAuth.authStateChanges();
  }

  Future<UserCredential> emailSignUp(String email, String password) async {
    return _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> githubSignIn() async {
    await _firebaseAuth.signInWithProvider(GithubAuthProvider());
  }
}

final authRepo = Provider((ref) {
  return AuthenticationRepo();
});

final authState = Provider((ref) {
  final repo = ref.read(authRepo);
  return repo.authStateChange();
});
