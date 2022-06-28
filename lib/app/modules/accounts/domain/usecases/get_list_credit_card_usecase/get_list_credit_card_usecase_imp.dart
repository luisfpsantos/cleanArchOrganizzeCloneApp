import 'package:organizze_app/app/modules/accounts/domain/entities/credit_card_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/get_list_credit_card_erros.dart';
import 'package:organizze_app/app/modules/accounts/domain/repositories/accounts_repository.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/get_list_credit_card_usecase/get_list_credit_card_usecase.dart';

class GetListCreditCardUsecaseImp implements GetListCreditCardUsecase {
  final AccountsRepository _accountsRepository;

  GetListCreditCardUsecaseImp(this._accountsRepository);

  @override
  Future<Either<GetListCreditCardErros, List<CreditCardEntity>>> call(
    String userId,
  ) async {
    return await _accountsRepository.getCreditCards(userId);
  }
}
