import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/painel/domain/entities/account_total_entity.dart';
import 'package:organizze_app/app/painel/domain/errors/get_list_accounts_total_errors.dart';

abstract class GetListAccountsTotalUsecase {
  Future<Either<GetListAccountsTotalErrors, List<AccountTotalEntity>>> call();
}
