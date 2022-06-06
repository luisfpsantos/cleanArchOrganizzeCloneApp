import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/login/domain/usecases/verify_login_usecase/verify_login_usecase_imp.dart';
import 'package:organizze_app/app/login/external/datasources/firebase/verify_login_datasource_imp.dart';
import 'package:organizze_app/app/login/infra/repositories/verify_login_repository_imp.dart';
import 'package:organizze_app/app/login/presenter/views/login_view/login_view_bloc/login_view_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class LoginViewDependencies {
  static List<SingleChildWidget> providers() {
    return [
      Provider(
        create: (_) => VerifyLoginDatasourceImp(FirebaseFirestore.instance),
      ),
      Provider(
        create: (context) =>
            VerifyLoginRepositoryImp(context.read<VerifyLoginDatasourceImp>()),
      ),
      Provider(
        create: (context) =>
            VerifyLoginUsecaseImp(context.read<VerifyLoginRepositoryImp>()),
      ),
      Provider(
        create: (context) =>
            LoginViewBloc(context.read<VerifyLoginUsecaseImp>()),
      ),
    ];
  }
}
