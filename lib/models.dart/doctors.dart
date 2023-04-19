class Doctor {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? role;

  Doctor(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.role});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['password'] = password;
    data['role'] = role;
    return data;
  }
}
