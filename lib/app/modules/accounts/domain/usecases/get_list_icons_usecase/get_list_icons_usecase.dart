import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/icon_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/get_list_icons_errors.dart';

abstract class GetListIconsUsecase {
  Future<Either<GetListIconsErrors, List<IconEntity>>> call(String assetPath);
}
