abstract class AccountViewEvents {}

class FetchAccounts extends AccountViewEvents {
  final String userId;

  FetchAccounts(this.userId);
}
