import 'package:organizze_app/app/modules/accounts/domain/errors/get_list_icons_errors.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/accounts/domain/repositories/accounts_repository.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/get_list_icons_usecase/get_list_icons_usecase.dart';

class GetListIconsUsecaseImp implements GetListIconsUsecase {
  final AccountsRepository _accountsRepository;

  GetListIconsUsecaseImp(this._accountsRepository);

  @override
  Future<Either<GetListIconsErrors, List<String>>> call(
      String assetPath) async {
    return await _accountsRepository.getIcons(assetPath);
  }
}
