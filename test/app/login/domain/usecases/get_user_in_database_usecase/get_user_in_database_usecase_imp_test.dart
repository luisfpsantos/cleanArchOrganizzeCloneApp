import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/login/domain/entities/logged_user_entity.dart';
import 'package:organizze_app/app/login/domain/errors/get_user_in_database_errors.dart';
import 'package:organizze_app/app/login/domain/repositories/get_user_in_database_repository.dart';
import 'package:organizze_app/app/login/domain/usecases/get_user_in_database_usecase/get_user_in_database_usecase_imp.dart';

class RepositoryMock extends Mock implements GetUserInDatabaseRepository {}

void main() {
  final repositoryMock = RepositoryMock();
  final usecase = GetUserInDatabaseUsecaseImp(repositoryMock);

  test('should return LoggedUserEntity', () async {
    when(() => repositoryMock(any())).thenAnswer((_) async => Right(
          LoggedUserEntity(name: 'name', user: 'user', authenticated: true),
        ));

    var result = await usecase('luis');

    expect(result.fold(id, id), isA<LoggedUserEntity>());
  });

  test('should return error', () async {
    when(() => repositoryMock(any())).thenAnswer((_) async => Left(
          UserNotAuthenticated('test'),
        ));

    var result = await usecase('luis');

    expect(result.fold(id, id), isA<GetUserInDatabaseErrors>());
  });
}
