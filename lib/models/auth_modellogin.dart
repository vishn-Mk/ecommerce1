class AuthLmodel {
  String? username;
  String? password;
  String? email;
  String? phone;
  String? name;
  String? sId;
  int? iV;

  AuthLmodel({
    this.username,
    this.password,
    this.email,
    this.phone,
    this.name,
    this.sId,
    this.iV,
  });

  AuthLmodel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;

    return data;
  }
}