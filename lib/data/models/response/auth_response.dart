class AuthResponse {
  final String email;
  final String token;
  final int uid;
  final String message;

  const AuthResponse({
    required this.email,
    required this.token,
    required this.uid,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'token': token,
      'uid': uid,
      'message': message,
    };
  }

  factory AuthResponse.fromMap(Map<String, dynamic> map) {
    return AuthResponse(
      email: map['email'] as String,
      token: map['token'] as String,
      uid: map['uid'] as int,
      message: map['message'] as String,
    );
  }
}