import 'package:organizze_app/app/modules/accounts/domain/entities/icon_entity.dart';

abstract class SelectIconAccountViewStates {}

class IconsIdle extends SelectIconAccountViewStates {}

class IconsLoading extends SelectIconAccountViewStates {}

class IconsError extends SelectIconAccountViewStates {
  final String msg;

  IconsError(this.msg);
}

class IconsSuccess extends SelectIconAccountViewStates {
  final List<IconEntity> icons;

  IconsSuccess(this.icons);
}
