import 'package:asoude/model/User.dart';

class LoginResponseEntity {
  final int code;

  LoginResponseEntity({this.code});

  factory LoginResponseEntity.fromJson(Map<String, dynamic> json) {
    return LoginResponseEntity(
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    return data;
  }
}

class VerifyResponseEntity {
  final String token;
  final User user;

  VerifyResponseEntity({this.token, this.user});

  factory VerifyResponseEntity.fromJson(Map<String, dynamic> json) {
    return VerifyResponseEntity(
        token: json['token'],
        user: json['user'] != null ? new User.fromJson(json['user']) : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}
