import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/login/domain/repositories/save_login_local_repository.dart';
import 'package:organizze_app/app/login/domain/repositories/verify_login_repository.dart';
import 'package:organizze_app/app/login/domain/usecases/save_login_local_usecase/save_login_local_usecase.dart';
import 'package:organizze_app/app/login/domain/usecases/save_login_local_usecase/save_login_local_usecase_imp.dart';
import 'package:organizze_app/app/login/domain/usecases/verify_login_usecase/verify_login_usecase.dart';
import 'package:organizze_app/app/login/domain/usecases/verify_login_usecase/verify_login_usecase_imp.dart';
import 'package:organizze_app/app/login/external/datasources/firebase/verify_login_datasource_imp.dart';
import 'package:organizze_app/app/login/external/datasources/local/save_login_local_datasource_imp.dart';
import 'package:organizze_app/app/login/infra/datasources/save_login_local_datasource.dart';
import 'package:organizze_app/app/login/infra/datasources/verify_login_datasource.dart';
import 'package:organizze_app/app/login/infra/repositories/save_login_local_repository_imp.dart';
import 'package:organizze_app/app/login/infra/repositories/verify_login_repository_imp.dart';
import 'package:organizze_app/app/login/presenter/views/login_view/login_view_bloc/login_view_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewDependencies {
  static List<SingleChildWidget> providers() {
    return [
      Provider<VerifyLoginDatasource>(
        create: (_) => VerifyLoginDatasourceImp(FirebaseFirestore.instance),
      ),
      Provider<VerifyLoginRepository>(
        create: (context) => VerifyLoginRepositoryImp(context.read()),
      ),
      Provider<VerifyLoginUsecase>(
        create: (context) => VerifyLoginUsecaseImp(context.read()),
      ),
      Provider<SaveLoginLocalDatasource>(
        create: (_) =>
            SaveLoginLocalDatasourceImp(SharedPreferences.getInstance()),
      ),
      Provider<SaveLoginLocalRepository>(
        create: (context) => SaveLoginLocalRepositoryImp(context.read()),
      ),
      Provider<SaveLoginLocalUsecase>(
        create: (context) => SaveLoginLocalUsecaseImp(context.read()),
      ),
      Provider(
        create: (context) => LoginViewBloc(context.read(), context.read()),
      ),
    ];
  }
}
