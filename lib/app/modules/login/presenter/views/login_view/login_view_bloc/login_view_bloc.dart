import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizze_app/app/modules/login/domain/errors/login_errors.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/login_usecase/login_usecase.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/save_login_local_usecase/save_login_local_usecase.dart';
import 'package:organizze_app/app/modules/login/presenter/views/login_view/login_view_bloc/login_view_events.dart';
import 'package:organizze_app/app/modules/login/presenter/views/login_view/login_view_bloc/login_view_states.dart';

class LoginViewBloc extends Bloc<LoginViewEvents, LoginViewStates> {
  final LoginUsecase _loginUsecase;
  final SaveLoginLocalUsecase _saveLoginLocalUsecase;

  LoginViewBloc(
    this._loginUsecase,
    this._saveLoginLocalUsecase,
  ) : super(LoginIdle()) {
    on<VerifyLoginEvent>(_verifyLoginEvent);
    on<CleanViewErrorsEvent>(_cleanViewErrors);
    on<SplashErrorEvent>(_splashError);
  }

  Future<void> _verifyLoginEvent(VerifyLoginEvent event, emit) async {
    emit(LoginLoading());

    final result = await _loginUsecase(event.user, event.password);

    final validLogin = result.fold(
      (error) {
        if (error is UserOrPasswordInvalid) {
          emit(LoginError('Usuario ou senha invalidos'));
        }
        if (error is UserNotAuthenticated) {
          emit(LoginError('Usuario não esta habilitado para usar o sistema'));
        }
      },
      (success) => success,
    );

    if (validLogin != null) {
      if (event.remeberMe) {
        final saveLogin = await _saveLoginLocalUsecase(
          validLogin.userId,
          event.user,
          event.password,
        );
        saveLogin.fold(
          (error) => emit(LoginError('Não foi possivel lembrar usuario')),
          (sucess) => emit(LoginSuccess(validLogin)),
        );
      } else {
        emit(LoginSuccess(validLogin));
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
