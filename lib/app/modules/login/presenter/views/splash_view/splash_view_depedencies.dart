import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/modules/login/domain/repositories/get_user_local_repository.dart';
import 'package:organizze_app/app/modules/login/domain/repositories/verify_login_repository.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/get_user_local_usecase/get_user_local_usecase.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/get_user_local_usecase/get_user_local_usecase_imp.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/verify_login_usecase/verify_login_usecase.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/verify_login_usecase/verify_login_usecase_imp.dart';
import 'package:organizze_app/app/modules/login/external/datasources/firebase/verify_login_datasource_imp.dart';
import 'package:organizze_app/app/modules/login/external/datasources/local/get_user_local_datasource_imp.dart';
import 'package:organizze_app/app/modules/login/infra/datasources/get_user_local_datasource.dart';
import 'package:organizze_app/app/modules/login/infra/datasources/verify_login_datasource.dart';
import 'package:organizze_app/app/modules/login/infra/repositories/get_user_local_repository_imp.dart';
import 'package:organizze_app/app/modules/login/infra/repositories/verify_login_repository_imp.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashViewDependencies {
  static List<SingleChildWidget> providers() {
    return [
      Provider<GetUserLocalDatasource>(
        create: (_) =>
            GetUserLocalDatasourceImp(SharedPreferences.getInstance()),
      ),
      Provider<GetUserLocalRepository>(
        create: (context) => GetUserLocalRepositoryImp(context.read()),
      ),
      Provider<GetUserLocalUsecase>(
        create: (context) => GetUserLocalUsecaseImp(context.read()),
      ),
      Provider<VerifyLoginDatasource>(
        create: (_) => VerifyLoginDatasourceImp(FirebaseFirestore.instance),
      ),
      Provider<VerifyLoginRepository>(
        create: (context) => VerifyLoginRepositoryImp(context.read()),
      ),
      Provider<VerifyLoginUsecase>(
        create: (context) => VerifyLoginUsecaseImp(context.read()),
      ),
    ];
  }
}
