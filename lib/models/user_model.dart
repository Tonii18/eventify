class UserModel {
  int? id;
  String name;
  String email;
  String password;
  String role;
  String? token;
  String? emailVerifiedAt;
  int? actived;
  int? deleted;
  String? code;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    this.token,
    this.emailVerifiedAt,
    this.actived,
    this.deleted,
    this.code,
  });

  //User to create in Login form
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '', // si no viene, '' por defecto
      password: json['password'] ?? '', // si no viene, '' por defecto
      role: json['role'] ?? '',
      token: json['token'],
      emailVerifiedAt: json['email_verified_at'],
      actived: json['actived'],
      deleted: json['deleted'],
      code: json['code'],
    );
  }

  //Json to create in Register form
  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'password': password, 'role': role};
  }
}
