import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/account_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/add_account_error.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/add_account_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/dtos/account_dto.dart';
import 'package:organizze_app/app/core/utils/firebase_collections.dart';

class AddAccountDatasourceImp implements AddAccountDatasource {
  final FirebaseFirestore _firebaseFirestore;

  AddAccountDatasourceImp(this._firebaseFirestore);

  @override
  Future<bool> call(AccountEntity account, String userId) async {
    final accountCollection = _firebaseFirestore.collection(
      '${FirebaseCollections.users}/$userId/${FirebaseCollections.accounts}',
    );

    final query =
        await accountCollection.where('name', isEqualTo: account.name).get();

    if (query.docs.isNotEmpty) {
      throw AccountAlreadyExists('account already exists');
    }

    final accountDto = AccountDto(
      name: account.name,
      balance: account.balance,
      iconPath: account.iconPath,
    );

    await accountCollection.add(accountDto.toMap()).onError(
        (e, _) => throw AddError('Error to add new account: ${e.toString()}'));

    return true;
  }
}
