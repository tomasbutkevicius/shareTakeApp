import 'package:firebase_auth/firebase_auth.dart';

class RemoteUserSource {
  final FirebaseAuth _firebaseAuth;

  RemoteUserSource({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<UserCredential> signIn({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      print(userCredential.toString());
      return userCredential;
      // return UserLocal(id: userCredential.user!.uid, token: userCredential, email: email, username: username, firstName: firstName, lastName: lastName);
    } on FirebaseAuthException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }

  }

  Future<String> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "user created";
    } on FirebaseAuthException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

}
