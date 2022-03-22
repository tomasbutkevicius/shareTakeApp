import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_local.g.dart';

@JsonSerializable()
class UserLocal extends Equatable {
  final String id;
  final String email;
  final String username;
  final String firstName;
  final String lastName;

  const UserLocal({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
  });

  factory UserLocal.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data() as Map<String, dynamic>;
    try {
      return UserLocal(
        id: snapshot.id,
        email: json["email"] as String,
        firstName: json["firstName"] as String,
        lastName: json["lastName"] as String,
        username: json["username"] as String,
      );
    } catch (e) {
      return UserLocal(id: "", email: "", username: "", firstName: "", lastName: "");
    }
  }

  @override
  String toString() {
    return 'User{id: $id, email: $email, username: $username, firstName: $firstName, lastName: $lastName,}';
  }

  @override
  List<Object?> get props => [
        id,
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
      email: email ?? this.email,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  factory UserLocal.fromMap(Map<String, dynamic> map) {
    return UserLocal(
      id: map['id'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
    );
  }
}
