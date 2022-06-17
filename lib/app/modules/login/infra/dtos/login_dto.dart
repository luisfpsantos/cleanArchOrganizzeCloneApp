import 'package:organizze_app/app/modules/login/domain/entities/login_entity.dart';

class LoginDto extends LoginEntity {
  LoginDto({
    required super.password,
    required super.user,
    required super.rememberMe,
  });

  static fromMap(Map<String, dynamic> map) {
    return LoginDto(
      password: map['password'],
      user: map['user'],
      rememberMe: map['rememberMe'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'password': password,
      'rememberMe': rememberMe,
    };
  }
}
