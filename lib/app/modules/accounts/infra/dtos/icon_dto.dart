import 'package:organizze_app/app/modules/accounts/domain/entities/icon_entity.dart';

class IconDto extends IconEntity {
  IconDto({
    required super.name,
    required super.path,
  });

  static IconDto fromMap(Map map) {
    return IconDto(
      name: map['name'],
      path: map['path'],
    );
  }
}
