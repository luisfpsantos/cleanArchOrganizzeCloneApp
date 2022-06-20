import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizze_app/app/modules/login/domain/errors/verify_login_errors.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/get_user_in_database_usecase/get_user_in_database_usecase.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/save_login_local_usecase/save_login_local_usecase.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/verify_login_usecase/verify_login_usecase.dart';
import 'package:organizze_app/app/modules/login/presenter/views/login_view/login_view_bloc/login_view_events.dart';
import 'package:organizze_app/app/modules/login/presenter/views/login_view/login_view_bloc/login_view_states.dart';

class LoginViewBloc extends Bloc<LoginViewEvents, LoginViewStates> {
  final VerifyLoginUsecase _verifyLoginUsecase;
  final SaveLoginLocalUsecase _saveLoginLocalUsecase;
  final GetUserInDatabaseUsecase _getUserInDatabaseUsecase;

  LoginViewBloc(
    this._verifyLoginUsecase,
    this._saveLoginLocalUsecase,
    this._getUserInDatabaseUsecase,
  ) : super(LoginIdle()) {
    on<VerifyLoginEvent>(_verifyLoginEvent);
    on<CleanViewErrorsEvent>(_cleanViewErrors);
    on<SplashErrorEvent>(_splashError);
  }

  Future<void> _verifyLoginEvent(VerifyLoginEvent event, emit) async {
    emit(LoginLoading());

    final result =
        await _verifyLoginUsecase(event.login.user, event.login.password);

    final validLogin = result.fold(
      (error) {
        if (error is UserOrPasswordInvalid) {
          emit(LoginError('Usuario ou senha invalidos'));
        }
        if (error is RepositoryError) {
          emit(LoginError('Erro inesperado, contacte o administrador'));
        }
      },
      (success) => success,
    );

    if (validLogin != null) {
      final getUserDatabase = await _getUserInDatabaseUsecase(event.login.user);
      final loggedUser = getUserDatabase.fold(
        (error) {
          emit(LoginError('Não foi possivel buscar usuario no banco de dados'));
        },
        (success) => success,
      );

      if (loggedUser != null) {
        if (event.login.rememberMe) {
          final saveLogin = await _saveLoginLocalUsecase(event.login);
          saveLogin.fold(
            (error) => emit(LoginError('Não foi possivel lembrar usuario')),
            (sucess) => emit(LoginSuccess(loggedUser)),
          );
        } else {
          emit(LoginSuccess(loggedUser));
        }
      }
    }
  }

  Future<void> _cleanViewErrors(event, emit) async {
    emit(LoginIdle());
  }

  Future<void> _splashError(SplashErrorEvent event, emit) async {
    emit(LoginError(event.msgError));
  }
}
