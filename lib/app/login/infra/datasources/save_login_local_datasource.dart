import 'package:organizze_app/app/login/domain/entities/login_entity.dart';

abstract class SaveLoginLocalDatasource {
  Future<bool> call(LoginEntity login);
}
