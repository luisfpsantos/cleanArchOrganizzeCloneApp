import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/modules/login/domain/entities/user_entity.dart';
import 'package:organizze_app/app/modules/login/domain/errors/login_errors.dart';
import 'package:organizze_app/app/modules/login/domain/repositories/login_repository.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/login_usecase/login_usecase.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/login_usecase/login_usecase_imp.dart';
import 'package:organizze_app/app/modules/login/infra/dtos/user_dto.dart';

class RepositoryMock extends Mock implements LoginRepository {}

void main() {
  late LoginRepository repository;
  late LoginUsecase usecase;

  setUp(() {
    repository = RepositoryMock();
    usecase = LoginUsecaseImp(repository);
  });

  test('should return true, user authenticated', () async {
    when(() => repository.logIn(any(), any())).thenAnswer((_) async {
      return right(
        UserDto(
            name: 'name',
            user: 'user',
            authenticated: true,
            userId: 'userId',
            accessLevel: 'accessLevel'),
      );
    });

    final result = await usecase.call('luis', '1234');

    expect(result.fold(id, id), isA<UserEntity>());
  });

  test('should return user or password error, when user is null', () async {
    final result = await usecase('', '1234');

    expect(result.fold(id, id), isA<UserOrPasswordInvalid>());
  });

  test('should return user or password error, when password is null', () async {
    final result = await usecase('234234', '');

    expect(result.fold(id, id), isA<UserOrPasswordInvalid>());
  });
}
