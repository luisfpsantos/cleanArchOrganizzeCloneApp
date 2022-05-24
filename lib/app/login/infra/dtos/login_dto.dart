import 'package:organizze_app/app/login/domain/entities/login_entity.dart';

class LoginDto extends LoginEntity {
  LoginDto({
    required super.password,
    required super.user,
    required super.rememberMe,
  });

  @override
  String toString() {
    return 'user: $user, password: $password, rememberMe: $rememberMe';
  }
}
