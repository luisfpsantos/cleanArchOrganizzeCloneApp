abstract class EditAccountDatasource {
  Future<bool> call(
    Map<String, dynamic> newAccount,
    String accountID,
    String userID,
  );
}
