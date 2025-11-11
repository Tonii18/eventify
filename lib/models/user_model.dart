class UserModel {
  final int id;
  final String name;
  final String email;
  final String role;
  final String? token;
  final String? emailVerifiedAt;
  final int? actived;
  final int? deleted;
  final String? code;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.token,
    this.emailVerifiedAt,
    this.actived,
    this.deleted,
    this.code,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    String role = json['role'] ?? 'u';
    if (!['a', 'u', 'o'].contains(role)) {
      role = 'u';
    }
    
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: role,
      token: json['token'], //only in login
      emailVerifiedAt: json['email_verified_at'],
      actived: json['actived'],
      deleted: json['deleted'],
      code: json['code'],
    );
  }
}
