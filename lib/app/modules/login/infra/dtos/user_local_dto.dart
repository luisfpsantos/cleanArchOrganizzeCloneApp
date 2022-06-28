import 'package:organizze_app/app/modules/login/domain/entities/user_local_entity.dart';

class UserLocalDto extends UserLocalEntity {
  UserLocalDto({
    required super.user,
    required super.userID,
    required super.password,
  });

  static UserLocalDto fromMap(dynamic map) {
    return UserLocalDto(
      user: map['user'],
      userID: map['userID'],
      password: map['password'],
    );
  }
}
