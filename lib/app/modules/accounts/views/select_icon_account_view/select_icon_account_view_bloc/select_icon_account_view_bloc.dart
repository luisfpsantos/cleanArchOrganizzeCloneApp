import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/get_list_icons_usecase/get_list_icons_usecase.dart';
import 'package:organizze_app/app/modules/accounts/views/select_icon_account_view/select_icon_account_view_bloc/select_icon_account_view_events.dart';
import 'package:organizze_app/app/modules/accounts/views/select_icon_account_view/select_icon_account_view_bloc/select_icon_account_view_states.dart';

class SelectIconAccountViewBloc
    extends Bloc<SelectIconAccountViewEvents, SelectIconAccountViewStates> {
  final GetListIconsUsecase _getListIconsUsecase;

  SelectIconAccountViewBloc(this._getListIconsUsecase) : super(IconsIdle()) {
    on<FetchAccountIcons>(_fetchIcons);
  }

  Future<void> _fetchIcons(FetchAccountIcons event, emit) async {
    emit(IconsLoading());
    final result = await _getListIconsUsecase(event.assetPath);
    result.fold(
      (error) => emit(IconsError('Não foi encontrado nenhum icone')),
      (success) => emit(IconsSuccess(success)),
    );
  }
}
