import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/modules/accounts/domain/repositories/get_list_account_repository.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/get_list_account_usecase/get_list_account_usecase.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/get_list_account_usecase/get_list_account_usecase_imp.dart';
import 'package:organizze_app/app/modules/accounts/external/datasources/firebase/get_list_account_datasource_imp.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/get_list_account_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/repositories/get_list_account_repository_imp.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AccountsViewDependencies {
  static List<SingleChildWidget> providers() {
    return [
      Provider<GetListAccountDatasource>(
        create: (_) => GetListAccountDatasourceImp(FirebaseFirestore.instance),
      ),
      Provider<GetListAccountRepository>(
        create: (context) => GetListAccountRepositoryImp(context.read()),
      ),
      Provider<GetListAccountUsecase>(
        create: (context) => GetListAccountUsecaseImp(context.read()),
      ),
    ];
  }
}
