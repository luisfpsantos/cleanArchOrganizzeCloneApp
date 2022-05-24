import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/login/domain/errors/verify_login_errors.dart';
import 'package:organizze_app/app/login/domain/repositories/verify_login_repository.dart';
import 'package:organizze_app/app/login/domain/usecases/verify_login_usecase/verify_login_usecase_imp.dart';

class RepositoryMock extends Mock implements VerifyLoginRepository {}

void main() {
  final repository = RepositoryMock();
  final usecase = VerifyLoginUsecaseImp(repository);

  test('should return true, user authenticated', () async {
    when(() => repository(any(), any())).thenAnswer((_) async {
      return const Right(true);
    });

    final result = await usecase.call('luis', '1234');

    expect(result.fold(id, id), true);
  });

  test('should return user or password error, when user is null', () async {
    final result = await usecase.call('', '1234');

    expect(result.fold(id, id), isA<UserOrPasswordInvalid>());
  });

  test('should return user or password error, when password is null', () async {
    final result = await usecase.call('234234', '');

    expect(result.fold(id, id), isA<UserOrPasswordInvalid>());
  });
}
