abstract class AccountViewEvents {}

class FetchAccounts extends AccountViewEvents {
  final String userId;
  final String accountType;

  FetchAccounts(this.userId, this.accountType);
}
