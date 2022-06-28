import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:organizze_app/app/modules/accounts/domain/repositories/accounts_repository.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/add_account_usecase/add_account_usecase.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/add_account_usecase/add_account_usecase_imp.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/add_credit_card_usecase/add_account_usecase_imp.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/add_credit_card_usecase/add_credit_card_usecase.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/get_list_account_usecase/get_list_account_usecase.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/get_list_account_usecase/get_list_account_usecase_imp.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/get_list_credit_card_usecase/get_list_credit_card_usecase.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/get_list_credit_card_usecase/get_list_credit_card_usecase_imp.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/get_list_icons_usecase/get_list_icons_usecase.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/get_list_icons_usecase/get_list_icons_usecase_imp.dart';
import 'package:organizze_app/app/modules/accounts/external/datasources/firebase/add_account_datasource_imp.dart';
import 'package:organizze_app/app/modules/accounts/external/datasources/firebase/add_credit_card_datasource_imp.dart';
import 'package:organizze_app/app/modules/accounts/external/datasources/firebase/get_list_account_datasource_imp.dart';
import 'package:organizze_app/app/modules/accounts/external/datasources/firebase/get_list_credit_card_datasource_imp.dart';
import 'package:organizze_app/app/modules/accounts/external/datasources/local/get_list_icons_datasource_imp.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/add_account_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/add_credit_card_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/get_list_account_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/get_list_credit_card_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/get_list_icons_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/repositories/accounts_repository_imp.dart';
import 'package:organizze_app/app/modules/accounts/views/accounts_view/accounts_view_bloc/accounts_view_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AccountsDependencies {
  static List<SingleChildWidget> providers() {
    return [
      //DATASOURCES
      Provider<GetListAccountDatasource>(
        create: (_) => GetListAccountDatasourceImp(FirebaseFirestore.instance),
      ),
      Provider<GetListCreditCardDatasource>(
        create: (_) =>
            GetListCreditCardDatasourceImp(FirebaseFirestore.instance),
      ),
      Provider<AddAccountDatasource>(
        create: (_) => AddAccountDatasourceImp(FirebaseFirestore.instance),
      ),
      Provider<AddCreditCardDatasource>(
        create: (_) => AddCreditCardDatasourceImp(FirebaseFirestore.instance),
      ),
      Provider<GetListIconsDatasource>(
        create: (_) => GetListIconsDatasourceImp(rootBundle),
      ),

      //REPOSITORIES
      Provider<AccountsRepository>(
        create: (context) => AccountsRepositoryImp(
          context.read(),
          context.read(),
          context.read(),
          context.read(),
          context.read(),
        ),
      ),

      //USECASES
      Provider<GetListAccountUsecase>(
        create: (context) => GetListAccountUsecaseImp(context.read()),
      ),
      Provider<GetListCreditCardUsecase>(
        create: (context) => GetListCreditCardUsecaseImp(context.read()),
      ),
      Provider<AddAccountUsecase>(
        create: (context) => AddAccountUsecaseImp(context.read()),
      ),
      Provider<AddCreditCardUsecase>(
        create: (context) => AddCreditCardUsecaseImp(context.read()),
      ),
      Provider<GetListIconsUsecase>(
        create: (context) => GetListIconsUsecaseImp(context.read()),
      ),

      //BLOC
      Provider<AccountsViewBloc>(
        create: (context) => AccountsViewBloc(context.read()),
      )
    ];
  }
}
