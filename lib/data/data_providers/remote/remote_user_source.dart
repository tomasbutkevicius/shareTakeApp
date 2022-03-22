import 'package:books_finder/books_finder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_take/constants/api.dart';
import 'package:share_take/data/models/book/book_local.dart';
import 'package:share_take/data/models/book_wants/book_wants_remote.dart';
import 'package:share_take/data/models/request/book_want_request.dart';
import 'package:share_take/data/models/request/register_request.dart';
import 'package:share_take/data/models/user/user_local.dart';

class RemoteUserSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore fireStore;

  RemoteUserSource({
    required this.fireStore,
    required this.firebaseAuth,
  });

  //AUTHENTICATION
  Future<UserCredential> signIn({required String email, required String password}) async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {}
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

  Future signOut() async {
    try {
      await firebaseAuth.signOut();
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

  //USER PROFILE
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

  //APP USERS
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

  //WISH LIST
  Future<List<BookWantsRemote>> getUserWishList(String userId) async {
    try {
      CollectionReference wantedCollection = fireStore.collection(StaticApi.wantedCollection);
      List<QueryDocumentSnapshot> userWantedItemList =
          await wantedCollection.where('userId', isEqualTo: userId).get().then((snapshot) => snapshot.docs);
      if (userWantedItemList.isNotEmpty) {
        return userWantedItemList.map((e) => BookWantsRemote.fromSnapshot(e)).toList();
      } else {
        return [];
      }
    } on FirebaseException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

  Future addBookToWishList(
    String bookId,
  ) async {
    if (!_userLoggedIn()) {
      throw Exception("User not found. Please login");
    }

    try {
      String currentUserId = firebaseAuth.currentUser!.uid;
      List<BookWantsRemote> bookWants = await getUserWishList(currentUserId);

      BookWantsRemote? found;

      try {
        found = bookWants.firstWhere((element) => element.bookId == bookId);
      } catch (e) {}

      if (found != null) {
        throw Exception("Book already in wish list");
      } else {
        await fireStore
            .collection(StaticApi.wantedCollection)
            .doc(currentUserId + bookId)
            .set(BookWantRequest(userId: currentUserId, bookId: bookId).toMap());
      }
    } on FirebaseException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

  Future removeBookWant(String id) async {
    try {
    await fireStore
        .collection(StaticApi.wantedCollection)
        .doc(id).delete();
    } on FirebaseException catch (firebaseException) {
      throw Exception(firebaseException.message);
    }
  }

  bool _userLoggedIn() => firebaseAuth.currentUser != null;

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();
}
