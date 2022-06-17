import 'package:organizze_app/app/modules/accounts/domain/entities/account_entity.dart';

abstract class GetListAccountDatasource {
  Future<List<AccountEntity>> call(String userId);
}
