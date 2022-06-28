abstract class LoginDatasource {
  Future<Map> call(String user, String password);
}
