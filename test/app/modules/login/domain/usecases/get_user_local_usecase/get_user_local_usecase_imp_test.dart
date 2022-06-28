import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/modules/login/domain/entities/user_local_entity.dart';
import 'package:organizze_app/app/modules/login/domain/errors/get_user_local_errors.dart';
import 'package:organizze_app/app/modules/login/domain/repositories/user_local_respository.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/get_user_local_usecase/get_user_local_usecase.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/get_user_local_usecase/get_user_local_usecase_imp.dart';
import 'package:organizze_app/app/modules/login/infra/dtos/user_local_dto.dart';

class RepositoryMock extends Mock implements UserLocalRepository {}

void main() {
  late UserLocalRepository repository;
  late GetUserLocalUsecase usecase;

  setUp(() {
    repository = RepositoryMock();
    usecase = GetUserLocalUsecaseImp(repository);
  });

  test('should return userLocalEntity', () async {
    when(() => repository.getUserLocal()).thenAnswer(
      (_) async => right(
          UserLocalDto(user: 'user', userID: 'userID', password: 'password')),
    );

    var result = await usecase();

    expect(result.fold(id, id), isA<UserLocalEntity>());
  });

  test('should return error type GetUserLocalErrors', () async {
    when(() => repository.getUserLocal()).thenAnswer(
      (_) async => left(LocalUserNotFound('test')),
    );

    var result = await usecase();

    expect(result.fold(id, id), isA<LocalUserNotFound>());
  });
}
