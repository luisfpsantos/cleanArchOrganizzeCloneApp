import 'package:organizze_app/app/login/domain/entities/logged_user_entity.dart';

abstract class GetUserInDatabaseDatasource {
  Future<LoggedUserEntity> call(String loggedUser);
}
