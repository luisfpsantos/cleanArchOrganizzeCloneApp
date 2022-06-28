import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/core/modules/verify_user/domain/repositories/verify_user_repository.dart';
import 'package:organizze_app/app/core/modules/verify_user/domain/usecases/verify_user_by_id_usecase/verify_user_by_id_usecase.dart';
import 'package:organizze_app/app/core/modules/verify_user/domain/usecases/verify_user_by_id_usecase/verify_user_by_id_usecase_imp.dart';
import 'package:organizze_app/app/core/modules/verify_user/external/datasources/firebase/verify_user_by_id_datasource_imp.dart';
import 'package:organizze_app/app/core/modules/verify_user/infra/datasources/verify_user_by_id_datasource.dart';
import 'package:organizze_app/app/core/modules/verify_user/infra/repositories/verify_user_repository_imp.dart';
import 'package:organizze_app/app/core/modules/verify_user/presenter/verify_user_bloc/verify_user_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class VerifyUserCoreDependencies {
  static List<SingleChildWidget> providers() {
    return [
      Provider<VerifyUserByIdDatasource>(
        create: (_) => VerifyUserByIdDatasourceImp(FirebaseFirestore.instance),
      ),
      Provider<VerifyUserRepository>(
        create: (context) => VerifyUserRepositoryImp(context.read()),
      ),
      Provider<VerifyUserByIdUsecase>(
        create: (context) => VerifyUserByIdUsecaseImp(context.read()),
      ),
      Provider<VerifyUserBloc>(
        create: (context) => VerifyUserBloc(context.read()),
      ),
    ];
  }
}
