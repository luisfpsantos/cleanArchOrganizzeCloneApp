import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/login/domain/entities/login_entity.dart';
import 'package:organizze_app/app/login/domain/errors/get_user_local_errors.dart';
import 'package:organizze_app/app/login/domain/repositories/get_user_local_repository.dart';
import 'package:organizze_app/app/login/domain/usecases/get_user_local_usecase/get_user_local_usecase.dart';
import 'package:organizze_app/app/login/domain/usecases/get_user_local_usecase/get_user_local_usecase_imp.dart';

class RepositoryMock extends Mock implements GetUserLocalRepository {}

void main() {
  late RepositoryMock repository;
  late GetUserLocalUsecase usecase;

  setUp(() {
    repository = RepositoryMock();
    usecase = GetUserLocalUsecaseImp(repository);
  });

  test('should return LoginEntity', () async {
    when(() => repository()).thenAnswer((_) async =>
        right(LoginEntity(user: '', password: '', rememberMe: false)));

    var result = await usecase();

    expect(result.fold(id, id), isA<LoginEntity>());
  });

  test('should return error type GetUserLocalErrors', () async {
    when(() => repository())
        .thenAnswer((_) async => left(LocalUserNotFound('test')));

    var result = await usecase();

    expect(result.fold(id, id), isA<LocalUserNotFound>());
  });
}
