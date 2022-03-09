import 'package:share_take/data/data_providers/local/local_user_source.dart';
import 'package:share_take/data/data_providers/remote/remote_user_source.dart';
import 'package:share_take/data/models/user/user.dart';

class UserRepository {
  final LocalUserSource _localUserSource;
  final RemoteUserSource _remoteUserSource;

  UserRepository(this._localUserSource, this._remoteUserSource);

  Future<User> authenticate({
    required String email,
    required String password,
  }) async {
    // AuthResponse authResponse =
    //     await _remoteUserSource.authenticate(email: email, password: password);

    User user = await _localUserSource.authenticate(email: email, password: password);

    await _localUserSource.setActiveUser(user);
    return user;
  }

  Future<User?> getActiveUser() async {
    User? user = await _localUserSource.getActiveUser();

    return user;
  }

  Future logout() async {
    _localUserSource.removeActiveUser();
  }

  Future updateLocalUser(User user) async {
    await _localUserSource.updateUser(user);
  }

  // Future updateRemoteSettings(String token) async {
  //   await _remoteUserSource.postSettings(token);
  // }
}
