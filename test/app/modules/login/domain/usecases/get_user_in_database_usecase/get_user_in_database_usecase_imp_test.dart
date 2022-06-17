import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/modules/login/domain/entities/logged_user_entity.dart';
import 'package:organizze_app/app/modules/login/domain/errors/get_user_in_database_errors.dart';
import 'package:organizze_app/app/modules/login/domain/repositories/get_user_in_database_repository.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/get_user_in_database_usecase/get_user_in_database_usecase.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/get_user_in_database_usecase/get_user_in_database_usecase_imp.dart';

class RepositoryMock extends Mock implements GetUserInDatabaseRepository {}

void main() {
  late RepositoryMock repository;
  late GetUserInDatabaseUsecase usecase;

  setUpAll(() {}); // inicia uma vez apenas

  setUp(() {
    repository = RepositoryMock();
    usecase = GetUserInDatabaseUsecaseImp(repository);
  }); // inicia toda vez que um test for iniciado

  test('should return LoggedUserEntity', () async {
    when(() => repository(any())).thenAnswer((_) async => right(
          LoggedUserEntity(
              name: 'name', user: 'user', authenticated: true, userId: ''),
        ));

    var result = await usecase('luis');

    expect(result.fold(id, id), isA<LoggedUserEntity>());
  });

  test('should return error', () async {
    when(() => repository(any())).thenAnswer((_) async => left(
          UserNotAuthenticated('test'),
        ));

    var result = await usecase('luis');

    expect(result.fold(id, id), isA<GetUserInDatabaseErrors>());
  });
}
