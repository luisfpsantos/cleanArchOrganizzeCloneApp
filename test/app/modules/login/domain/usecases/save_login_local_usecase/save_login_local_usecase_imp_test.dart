import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/modules/login/domain/errors/save_login_local_errors.dart';
import 'package:organizze_app/app/modules/login/domain/repositories/user_local_respository.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/save_login_local_usecase/save_login_local_usecase.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/save_login_local_usecase/save_login_local_usecase_imp.dart';

class RepositoryMock extends Mock implements UserLocalRepository {}

void main() {
  late UserLocalRepository repository;
  late SaveLoginLocalUsecase usecase;

  setUp(() {
    repository = RepositoryMock();
    usecase = SaveLoginLocalUsecaseImp(repository);
  });

  test('should return true, loginSaveLocally', () async {
    when(() => repository.saveLoginLocal(any(), any(), any()))
        .thenAnswer((_) async => right(true));

    var result = await usecase('', '', '');

    expect(result.fold(id, id), true);
  });

  test('should return UnableToSaveLoginLocal', () async {
    when(() => repository.saveLoginLocal(any(), any(), any())).thenAnswer(
      (_) async => left(UnableToSaveLoginLocal('')),
    );

    var result = await usecase('', '', '');

    expect(result.fold(id, id), isA<UnableToSaveLoginLocal>());
  });
}
