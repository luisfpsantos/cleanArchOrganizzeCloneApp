import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/modules/login/domain/repositories/login_repository.dart';
import 'package:organizze_app/app/modules/login/domain/repositories/user_local_respository.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/get_user_local_usecase/get_user_local_usecase.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/get_user_local_usecase/get_user_local_usecase_imp.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/login_usecase/login_usecase.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/login_usecase/login_usecase_imp.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/save_login_local_usecase/save_login_local_usecase.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/save_login_local_usecase/save_login_local_usecase_imp.dart';
import 'package:organizze_app/app/modules/login/external/datasources/firebase/login_datasource_imp.dart';
import 'package:organizze_app/app/modules/login/external/datasources/local/get_user_local_datasource_imp.dart';
import 'package:organizze_app/app/modules/login/external/datasources/local/save_login_local_datasource_imp.dart';
import 'package:organizze_app/app/modules/login/infra/datasources/get_user_local_datasource.dart';
import 'package:organizze_app/app/modules/login/infra/datasources/login_datasource.dart';
import 'package:organizze_app/app/modules/login/infra/datasources/save_login_local_datasource.dart';
import 'package:organizze_app/app/modules/login/infra/repositories/login_repository.dart';
import 'package:organizze_app/app/modules/login/infra/repositories/user_local_repository_imp.dart';
import 'package:organizze_app/app/modules/login/presenter/views/login_view/login_view_bloc/login_view_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginDependencies {
  static List<SingleChildWidget> providers() {
    return [
      //DATASOURCES
      Provider<LoginDatasource>(
        create: (_) => LoginDatasourceImp(FirebaseFirestore.instance),
      ),
      Provider<SaveLoginLocalDatasource>(
        create: (_) => SaveLoginLocalDatasourceImp(
          SharedPreferences.getInstance(),
        ),
      ),
      Provider<GetUserLocalDatasource>(
        create: (_) => GetUserLocalDatasourceImp(
          SharedPreferences.getInstance(),
        ),
      ),

      //REPOSITORIES
      Provider<LoginRepository>(
        create: (context) => LoginRepositoryImp(context.read()),
      ),
      Provider<UserLocalRepository>(
        create: (context) => UserLocalRepositoryImp(
          context.read(),
          context.read(),
        ),
      ),

      //USECASES
      Provider<LoginUsecase>(
        create: (context) => LoginUsecaseImp(context.read()),
      ),
      Provider<SaveLoginLocalUsecase>(
        create: (context) => SaveLoginLocalUsecaseImp(context.read()),
      ),
      Provider<GetUserLocalUsecase>(
        create: (context) => GetUserLocalUsecaseImp(context.read()),
      ),

      //BLOC
      Provider(
        create: (context) => LoginViewBloc(
          context.read(),
          context.read(),
        ),
      ),
    ];
  }
}
