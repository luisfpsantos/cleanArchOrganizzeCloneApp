import 'package:organizze_app/app/modules/login/domain/entities/user_entity.dart';

class UserDto extends UserEntity {
  UserDto({
    required super.name,
    required super.user,
    required super.authenticated,
    required super.userId,
    required super.accessLevel,
  });

  static fromMap(dynamic map) {
    return UserDto(
      name: map['name'],
      user: map['user'],
      authenticated: map['authenticated'],
      accessLevel: map['accessGroup'],
      userId: map['userId'],
    );
  }
}
