import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/login/domain/entities/login_entity.dart';
import 'package:organizze_app/app/login/domain/repositories/save_login_local_repository.dart';
import 'package:organizze_app/app/login/domain/usecases/save_login_local_usecase/save_login_local_usecase.dart';
import 'package:organizze_app/app/login/domain/usecases/save_login_local_usecase/save_login_local_usecase_imp.dart';

class RepositoryMock extends Mock implements SaveLoginLocalRepository {}

void main() {
  late RepositoryMock repository;
  late SaveLoginLocalUsecase usecase;

  setUpAll(() {
    registerFallbackValue(
      LoginEntity(user: 'luis', password: '1234', rememberMe: true),
    );
  });

  setUp(() {
    repository = RepositoryMock();
    usecase = SaveLoginLocalUsecaseImp(repository);
  });

  test('should return true, loginSaveLocally', () async {
    when(() => repository(any())).thenAnswer((_) async => const Right(true));

    var result = await usecase(
        LoginEntity(user: 'luis', password: '1234', rememberMe: true));

    expect(result.fold(id, id), true);
  });
}
