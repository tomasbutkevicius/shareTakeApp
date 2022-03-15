import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_take/data/data_providers/local/local_user_source.dart';
import 'package:share_take/data/data_providers/remote/remote_user_source.dart';
import 'package:share_take/data/models/request/register_request.dart';
import 'package:share_take/data/models/user/user_local.dart';

class UserRepository {
  final LocalUserSource _localUserSource;
  final RemoteUserSource _remoteUserSource;

  UserRepository(this._localUserSource, this._remoteUserSource);

  Future<UserLocal> authenticate({
    required String email,
    required String password,
  }) async {
    UserCredential userRemote = await _remoteUserSource.signIn(email: email, password: password);
    DocumentSnapshot? userDocument;
    UserLocal? userLocal;
    try {
      userDocument = await _remoteUserSource.getUserData(userId: userRemote.user!.uid, email: email);
      userLocal = UserLocal.fromSnapshot(email, userDocument);
    } catch (e) {
      print("ERROR RECEIVING USER INFO");
      print(e.runtimeType);
      print(e.toString());
    }

    userLocal ??= _handleUserDataNotReceived(userRemote, email);

    await _localUserSource.setActiveUser(userLocal);
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
    await _remoteUserSource.updateUserData(
      userLocal,
    );
  }

  Future<UserLocal?> getActiveUser() async {
    UserLocal? user = await _localUserSource.getActiveUser();
    //TODO: Update token
    return user;
  }

  Future logout() async {
    _localUserSource.removeActiveUser();
  }

  Future updateUser(UserLocal user) async {
    // await _localUserSource.updateUser(user);
  }

// Future updateRemoteSettings(String token) async {
//   await _remoteUserSource.postSettings(token);
// }
}
