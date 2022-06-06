import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizze_app/app/login/domain/usecases/verify_login_usecase/verify_login_usecase.dart';
import 'package:organizze_app/app/login/presenter/views/login_view/login_view_bloc/login_view_events.dart';
import 'package:organizze_app/app/login/presenter/views/login_view/login_view_bloc/login_view_states.dart';

class LoginViewBloc extends Bloc<LoginViewEvents, LoginViewStates> {
  final VerifyLoginUsecase _verifyLoginUsecase;

  LoginViewBloc(this._verifyLoginUsecase) : super(LoginIdle()) {
    on<VerifyLoginEvent>(_verifyLoginEvent);
  }

  Future<void> _verifyLoginEvent(event, emit) async {
    final result = await _verifyLoginUsecase(event.user, event.password);
    result.fold(
      (error) => print(LoginError(error.msg)),
      (success) => print(LoginSuccess()),
    );
  }
}
