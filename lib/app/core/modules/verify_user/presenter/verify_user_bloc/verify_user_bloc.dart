import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizze_app/app/core/modules/verify_user/domain/errors/verify_user_by_id_erros.dart';
import 'package:organizze_app/app/core/modules/verify_user/domain/usecases/verify_user_by_id_usecase/verify_user_by_id_usecase.dart';
import 'package:organizze_app/app/core/modules/verify_user/presenter/verify_user_bloc/verify_user_events.dart';
import 'package:organizze_app/app/core/modules/verify_user/presenter/verify_user_bloc/verify_user_states.dart';

class VerifyUserBloc extends Bloc<VerifyUserEvents, VerifyUserStates> {
  final VerifyUserByIdUsecase _verifyUserByIdUsecase;

  VerifyUserBloc(this._verifyUserByIdUsecase) : super(VerifyUserLoading()) {
    on<VerifyUser>(_verifyUser);
  }

  Future<void> _verifyUser(VerifyUser event, emit) async {
    final result = await _verifyUserByIdUsecase(event.userId);
    result.fold(
      (error) {
        if (error is UserNotAuthenticated) {
          emit(VerifyUserError('Usuario não esta habilitado para acessar'));
        }
        if (error is UserNotFound) {
          emit(VerifyUserError('Usuario não foi encontrado'));
        }
      },
      (sucess) => emit(VerifyUserSuccess()),
    );
  }
}
