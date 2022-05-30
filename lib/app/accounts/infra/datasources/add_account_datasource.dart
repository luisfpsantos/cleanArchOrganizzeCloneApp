import 'package:organizze_app/app/accounts/domain/entities/account_entity.dart';

abstract class AddAccountDatasource {
  Future<bool> call(AccountEntity account);
}
