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

    UserLocal userLocal = UserLocal.fromUserCredential(userRemote);

    await _localUserSource.setActiveUser(userLocal);
    return userLocal;
  }

  Future register(RegisterRequest registerRequest) async {
    UserCredential userCredential =
        await _remoteUserSource.signUp(email: registerRequest.email, password: registerRequest.password);

    await _remoteUserSource.updateUserData(
      userId: userCredential.user!.uid,
      firstName: registerRequest.firstName,
      lastName: registerRequest.lastName,
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

  Future updateLocalUser(UserLocal user) async {
    await _localUserSource.updateUser(user);
  }

// Future updateRemoteSettings(String token) async {
//   await _remoteUserSource.postSettings(token);
// }
}
