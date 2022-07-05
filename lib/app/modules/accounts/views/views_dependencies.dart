import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:organizze_app/app/modules/accounts/domain/repositories/accounts_repository.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/add_account_usecase/add_account_usecase.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/add_account_usecase/add_account_usecase_imp.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/add_credit_card_usecase/add_account_usecase_imp.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/add_credit_card_usecase/add_credit_card_usecase.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/edit_account_usecase/edit_account_usecase.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/edit_account_usecase/edit_account_usecase_imp.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/edit_credit_card_usecase/edit_credit_card_usecase.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/edit_credit_card_usecase/edit_credit_card_usecase_imp.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/get_list_account_usecase/get_list_account_usecase.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/get_list_account_usecase/get_list_account_usecase_imp.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/get_list_credit_card_usecase/get_list_credit_card_usecase.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/get_list_credit_card_usecase/get_list_credit_card_usecase_imp.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/get_list_icons_usecase/get_list_icons_usecase.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/get_list_icons_usecase/get_list_icons_usecase_imp.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/remove_account_usecase/remove_account_usecase.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/remove_account_usecase/remove_account_usecase_imp.dart';
import 'package:organizze_app/app/modules/accounts/external/datasources/firebase/add_account_datasource_imp.dart';
import 'package:organizze_app/app/modules/accounts/external/datasources/firebase/add_credit_card_datasource_imp.dart';
import 'package:organizze_app/app/modules/accounts/external/datasources/firebase/edit_account_datasource_imp.dart';
import 'package:organizze_app/app/modules/accounts/external/datasources/firebase/edit_credit_card_datasource_imp.dart';
import 'package:organizze_app/app/modules/accounts/external/datasources/firebase/get_list_account_datasource_imp.dart';
import 'package:organizze_app/app/modules/accounts/external/datasources/firebase/get_list_credit_card_datasource_imp.dart';
import 'package:organizze_app/app/modules/accounts/external/datasources/firebase/remove_account_datasource_imp.dart';
import 'package:organizze_app/app/modules/accounts/external/datasources/local/get_list_icons_datasource_imp.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/add_account_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/add_credit_card_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/edit_account_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/edit_credit_card_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/get_list_account_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/get_list_credit_card_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/get_list_icons_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/remove_account_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/repositories/accounts_repository_imp.dart';
import 'package:organizze_app/app/modules/accounts/views/accounts_view/accounts_view_bloc/accounts_view_bloc.dart';
import 'package:organizze_app/app/modules/accounts/views/add_account_view/add_account_view_bloc/add_account_view_bloc.dart';
import 'package:organizze_app/app/modules/accounts/views/edit_account_view/edit_account_viw_bloc/edit_account_view_bloc.dart';
import 'package:organizze_app/app/modules/accounts/views/select_icon_account_view/select_icon_account_view_bloc/select_icon_account_view_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AccountsDependencies {
  static List<SingleChildWidget> providers() {
    final firebaseInstance = FirebaseFirestore.instance;
    return [
      //DATASOURCES
      Provider<GetListAccountDatasource>(
        create: (_) => GetListAccountDatasourceImp(firebaseInstance),
      ),
      Provider<GetListCreditCardDatasource>(
        create: (_) => GetListCreditCardDatasourceImp(firebaseInstance),
      ),
      Provider<AddAccountDatasource>(
        create: (_) => AddAccountDatasourceImp(firebaseInstance),
      ),
      Provider<AddCreditCardDatasource>(
        create: (_) => AddCreditCardDatasourceImp(firebaseInstance),
      ),
      Provider<GetListIconsDatasource>(
        create: (_) => GetListIconsDatasourceImp(rootBundle),
      ),
      Provider<EditAccountDatasource>(
        create: (_) => EditAccountDatasourceImp(firebaseInstance),
      ),
      Provider<RemoveAccountDatasource>(
        create: (_) => RemoveAccountDatasourceImp(firebaseInstance),
      ),
      Provider<EditCreditCardDatasource>(
        create: (_) => EditCreditCardDatasourceImp(firebaseInstance),
      ),

      //REPOSITORIES
      Provider<AccountsRepository>(
        create: (context) => AccountsRepositoryImp(
          context.read(),
          context.read(),
          context.read(),
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
      Provider<EditAccountUsecase>(
        create: (context) => EditAccountUsecaseImp(context.read()),
      ),
      Provider<RemoveAccountUsecase>(
        create: (context) => RemoveAccountUsecaseImp(context.read()),
      ),
      Provider<EditCreditCardUsecase>(
        create: (context) => EditCreditCardUsecaseImp(context.read()),
      ),

      //BLOC
      Provider<AccountsViewBloc>(
        create: (context) => AccountsViewBloc(context.read()),
      ),
      Provider<SelectIconAccountViewBloc>(
        create: (context) => SelectIconAccountViewBloc(context.read()),
      ),
      Provider<AddAccountViewBloc>(
        create: (context) => AddAccountViewBloc(context.read()),
      ),
      Provider<EditAccountViewBloc>(
        create: (context) => EditAccountViewBloc(
          context.read(),
          context.read(),
        ),
      ),
    ];
  }
}
