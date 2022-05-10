class AuthRequest {
  final String email;
  final String password;

  const AuthRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory AuthRequest.fromMap(Map<String, dynamic> map) {
    return AuthRequest(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }
}