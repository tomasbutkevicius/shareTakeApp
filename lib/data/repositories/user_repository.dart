import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_take/data/data_providers/local/local_user_source.dart';
import 'package:share_take/data/data_providers/remote/remote_offer_source.dart';
import 'package:share_take/data/data_providers/remote/remote_user_source.dart';
import 'package:share_take/data/data_providers/remote/remote_wishlist_source.dart';
import 'package:share_take/data/models/book_offers/book_offer_remote.dart';
import 'package:share_take/data/models/book_wants/book_wants_remote.dart';
import 'package:share_take/data/models/request/book_offer_request.dart';
import 'package:share_take/data/models/request/book_want_request.dart';
import 'package:share_take/data/models/request/register_request.dart';
import 'package:share_take/data/models/user/user_local.dart';

class UserRepository {
  final LocalUserSource _localUserSource;
  final RemoteUserSource _remoteUserSource;
  final RemoteWishListSource _remoteWishListSource;
  final RemoteOfferSource _remoteOfferSource;

  UserRepository(
    this._localUserSource,
    this._remoteUserSource,
    this._remoteWishListSource,
    this._remoteOfferSource,
  );

  Future<UserLocal> authenticate({
    required String email,
    required String password,
  }) async {
    UserCredential userRemote = await _remoteUserSource.signIn(email: email, password: password);
    DocumentSnapshot? userDocument;
    UserLocal? userLocal;
    try {
      userDocument = await _remoteUserSource.getUserData(
        userId: userRemote.user!.uid,
      );
      userLocal = UserLocal.fromSnapshot(userDocument);
    } catch (e) {
      print("ERROR RECEIVING USER INFO");
      print(e.runtimeType);
      print(e.toString());
    }

    userLocal ??= _handleUserDataNotReceived(userRemote, email);

    await _localUserSource.setActiveUser(userLocal);
    await _localUserSource.setToken(password);

    return userLocal;
  }

  UserLocal _handleUserDataNotReceived(UserCredential userRemote, String email) {
    return UserLocal(id: userRemote.user!.uid, email: email, username: "", firstName: "", lastName: "");
  }

  Future register(RegisterRequest registerRequest) async {
    UserCredential userCredential =
        await _remoteUserSource.signUpWithEmailPassword(email: registerRequest.email, password: registerRequest.password);

    UserLocal userLocal = UserLocal(
      id: userCredential.user!.uid,
      email: registerRequest.email,
      username: "",
      firstName: registerRequest.firstName,
      lastName: registerRequest.lastName,
    );
    try {
      await _remoteUserSource.updateUserData(
        userLocal,
      );
    } catch (e) {
      throw Exception("Account created but received error creating user meta data");
    }
  }

  Future<UserLocal?> getActiveUser() async {
    UserLocal? user = await _localUserSource.getActiveUser();
    return user;
  }

  Future<String?> getUserId() async {
    User? user = _remoteUserSource.currentUser();
    if (user == null) {
      return null;
    }
    return user.uid;
  }

  Future<String?> getToken() async {
    return _localUserSource.getToken();
  }

  Future logout() async {
    await _remoteUserSource.signOut();
    await _localUserSource.logout();
  }

  Future updateUser(UserLocal user) async {
    // await _localUserSource.updateUser(user);
  }

  Future<List<UserLocal>> getAllUsers() async {
    return _remoteUserSource.getAllUsers();
  }

  Future<List<BookWantsRemote>> getUserBookWants(String userId) async {
    return _remoteWishListSource.getUserWishList(userId);
  }

  Future addBookToWishList(
    String bookId,
  ) async {
    if (!_remoteUserSource.userLoggedIn()) {
      throw Exception("User not found. Please login");
    }
    String currentUserId = _remoteUserSource.currentUser()!.uid;

    List<BookWantsRemote> bookWants = await _remoteWishListSource.getUserWishList(currentUserId);

    BookWantsRemote? found;

    try {
      found = bookWants.firstWhere((element) => element.bookId == bookId);
    } catch (e) {}

    if (found != null) {
      throw Exception("Book already in wish list");
    }

    await _remoteWishListSource.addBookToWishList(BookWantRequest(bookId: bookId, userId: currentUserId));
  }

  Future removeBookFromWishList(String bookId) async {
    if (!_remoteUserSource.userLoggedIn()) {
      throw Exception("User not found. Please login");
    }
    String currentUserId = _remoteUserSource.currentUser()!.uid;

    await _remoteWishListSource.removeBookWant(bookId, currentUserId);
  }

  Future addBookToOfferList(String bookId) async {
    if (!_remoteUserSource.userLoggedIn()) {
      throw Exception("User not found. Please login");
    }

    String currentUserId = _remoteUserSource.currentUser()!.uid;
    List<BookOfferRemote> offers = await _remoteOfferSource.getUserOfferList(currentUserId);

    BookOfferRemote? found;

    try {
      found = offers.firstWhere((element) => element.bookId == bookId);
    } catch (e) {}

    if (found != null) {
      throw Exception("You are already offering this book");
    } else {
      await _remoteOfferSource.addBookToOfferList(BookOfferRequest(userId: currentUserId, bookId: bookId));
    }
  }

  Future removeBookFromOfferList(String bookId) async {
    if (!_remoteUserSource.userLoggedIn()) {
      throw Exception("User not found. Please login");
    }

    String currentUserId = _remoteUserSource.currentUser()!.uid;

    await _remoteOfferSource.removeBookOffer(currentUserId + bookId);
  }
}
