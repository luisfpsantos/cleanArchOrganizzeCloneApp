abstract class EditCreditCardDatasource {
  Future<bool> call(
    Map<String, dynamic> newCreditCard,
    String accountID,
    String userID,
  );
}
