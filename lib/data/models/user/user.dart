import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final int id;
  final String token;
  final String email;
  final String username;
  final String firstName;
  final String lastName;

  const User({
    required this.id,
    required this.token,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
  });



  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User{id: $id, token: $token, email: $email, username: $username, firstName: $firstName, lastName: $lastName,}';
  }

  @override
  List<Object?> get props => [id, token, email, username, firstName, lastName,];

  User copyWith({
    int? id,
    String? token,
    String? email,
    String? password,
    String? username,
    String? firstName,
    String? lastName,
    bool? subscriptionActive,
    bool? firstLogin,
  }) {
    return User(
      id: id ?? this.id,
      token: token ?? this.token,
      email: email ?? this.email,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }
}