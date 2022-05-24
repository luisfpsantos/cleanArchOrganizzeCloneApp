import 'package:organizze_app/app/login/domain/entities/logged_user_entity.dart';

class LoggedUserDto extends LoggedUserEntity {
  LoggedUserDto({
    required super.name,
    required super.user,
    required super.authenticated,
  });

  static fromMap(Map<String, dynamic> map) {
    return LoggedUserDto(
      name: map['name'],
      user: map['user'],
      authenticated: map['authenticated'],
    );
  }
}
