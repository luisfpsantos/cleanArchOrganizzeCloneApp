import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizze_app/app/login/domain/errors/verify_login_errors.dart';
import 'package:organizze_app/app/login/domain/usecases/save_login_local_usecase/save_login_local_usecase.dart';
import 'package:organizze_app/app/login/domain/usecases/verify_login_usecase/verify_login_usecase.dart';
import 'package:organizze_app/app/login/presenter/views/login_view/login_view_bloc/login_view_events.dart';
import 'package:organizze_app/app/login/presenter/views/login_view/login_view_bloc/login_view_states.dart';

class LoginViewBloc extends Bloc<LoginViewEvents, LoginViewStates> {
  final VerifyLoginUsecase _verifyLoginUsecase;
  final SaveLoginLocalUsecase _saveLoginLocalUsecase;

  LoginViewBloc(
    this._verifyLoginUsecase,
    this._saveLoginLocalUsecase,
  ) : super(LoginIdle()) {
    on<VerifyLoginEvent>(_verifyLoginEvent);
    on<CleanViewErrorsEvent>(_cleanViewErrors);
    on<SaveLoginLocalEvent>(_saveLoginLocal);
  }

  Future<void> _verifyLoginEvent(event, emit) async {
    emit(LoginLoading());
    final result = await _verifyLoginUsecase(event.user, event.password);
    result.fold(
      (error) {
        if (error is UserOrPasswordInvalid) {
          emit(LoginError('Usuario ou senha invalidos'));
        }
        if (error is RepositoryError) {
          emit(LoginError('Erro inesperado, contacte o administrador'));
        }
      },
      (success) => emit(LoginSuccess()),
    );
  }

  Future<void> _cleanViewErrors(event, emit) async {
    emit(LoginIdle());
  }

  Future<void> _saveLoginLocal(event, emit) async {
    emit(LoginLoading());
    final result = await _saveLoginLocalUsecase(event.login);
    result.fold(
      (error) => emit(LoginError('Não foi possivel salvar usuario e senha')),
      (success) => emit(LoginIdle()),
    );
  }
}
