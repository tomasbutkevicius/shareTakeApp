import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_take/constants/api.dart';
import 'package:share_take/data/models/request/register_request.dart';
import 'package:share_take/data/models/user/user_local.dart';

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
      return userCredential;
    } on FirebaseAuthException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

  Future<UserCredential> signUpWithEmailPassword({required String email, required String password}) async {
    try {
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

  Future updateUserData(UserLocal userLocal) async {
    try {
      await fireStore.collection(StaticApi.usersCollection).doc(userLocal.id).set({
        'email': userLocal.email,
        'firstName': userLocal.firstName,
        'lastName': userLocal.lastName,
      });
    } on FirebaseAuthException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

  Future<DocumentSnapshot> getUserData({
    required String userId,
  }) async {
    try {
      DocumentReference userReference = fireStore.collection(StaticApi.usersCollection).doc(userId);
      DocumentSnapshot docSnap = await userReference.get();
      return docSnap;
    } on FirebaseException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

  Future<List<UserLocal>> getAllUsers() async {
    try {
      QuerySnapshot snapshot = await fireStore.collection(StaticApi.usersCollection).get();
      return snapshot.docs.map((doc) {
        UserLocal user = UserLocal.fromSnapshot(doc);
        return user;
      }).toList();
    } on FirebaseException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();
}
