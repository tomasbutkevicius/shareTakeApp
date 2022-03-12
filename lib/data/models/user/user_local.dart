import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_local.g.dart';

@JsonSerializable()
class UserLocal extends Equatable {
  final String id;
  final String token;
  final String email;
  final String username;
  final String firstName;
  final String lastName;

  const UserLocal({
    required this.id,
    required this.token,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
  });

  factory UserLocal.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  static UserLocal fromUserCredential(UserCredential userCredential) {
    return UserLocal(
      id: userCredential.user!.uid,
      token: userCredential.user!.refreshToken!,
      email: userCredential.user!.email!,
      username: "",
      firstName: "",
      lastName: "",
    );
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User{id: $id, token: $token, email: $email, username: $username, firstName: $firstName, lastName: $lastName,}';
  }

  @override
  List<Object?> get props => [
        id,
        token,
        email,
        username,
        firstName,
        lastName,
      ];

  UserLocal copyWith({
    String? id,
    String? token,
    String? email,
    String? password,
    String? username,
    String? firstName,
    String? lastName,
    bool? subscriptionActive,
    bool? firstLogin,
  }) {
    return UserLocal(
      id: id ?? this.id,
      token: token ?? this.token,
      email: email ?? this.email,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }
}
