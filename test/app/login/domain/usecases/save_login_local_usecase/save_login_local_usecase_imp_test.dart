import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/login/domain/entities/login_entity.dart';
import 'package:organizze_app/app/login/domain/repositories/save_login_local_repository.dart';
import 'package:organizze_app/app/login/domain/usecases/save_login_local_usecase/save_login_local_usecase_imp.dart';

class RepositoryMock extends Mock implements SaveLoginLocalRepository {}

void main() {
  final repository = RepositoryMock();
  final usecase = SaveLoginLocalUsecaseImp(repository);

  test('should return true, loginSaveLocally', () async {
    LoginEntity login =
        LoginEntity(user: 'luis', password: '1234', rememberMe: true);

    when(() => repository(login)).thenAnswer((_) async => const Right(true));

    var result = await usecase(login);

    expect(result.fold(id, id), true);
  });
}
