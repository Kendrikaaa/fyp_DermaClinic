class User {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String role = "Patient";

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
    );
  }
}
