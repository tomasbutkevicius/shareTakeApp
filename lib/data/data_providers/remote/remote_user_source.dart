import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_take/constants/api.dart';
import 'package:share_take/data/models/request/register_request.dart';

class RemoteUserSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore fireStore;

  RemoteUserSource({
    required this.fireStore,
    required this.firebaseAuth,
  });

  Future<UserCredential> signIn({required String email, required String password}) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      print(userCredential.toString());
      return userCredential;
      // return UserLocal(id: userCredential.user!.uid, token: userCredential, email: email, username: username, firstName: firstName, lastName: lastName);
    } on FirebaseAuthException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

  Future<UserCredential> signUp({required String email, required String password}) async {
    try {
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

  Future updateUserData({required String userId, required String firstName, required String lastName}) async {
    try {
      await fireStore.collection(StaticApi.usersCollection).doc(userId).set(
          {
            "firstName": firstName,
            "lastName": lastName,
          }
      );
    } on FirebaseAuthException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();
  
}
