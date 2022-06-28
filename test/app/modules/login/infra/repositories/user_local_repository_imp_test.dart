import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/modules/login/domain/errors/save_login_local_errors.dart';
import 'package:organizze_app/app/modules/login/domain/repositories/user_local_respository.dart';
import 'package:organizze_app/app/modules/login/infra/datasources/get_user_local_datasource.dart';
import 'package:organizze_app/app/modules/login/infra/datasources/save_login_local_datasource.dart';
import 'package:organizze_app/app/modules/login/infra/repositories/user_local_repository_imp.dart';

class SaveLoginLocalDatasourceMock extends Mock
    implements SaveLoginLocalDatasource {}

class GetUserLocalDatasourceMock extends Mock
    implements GetUserLocalDatasource {}

void main() {
  late UserLocalRepository userLocalRepository;
  late SaveLoginLocalDatasource saveLoginLocalDatasource;
  late GetUserLocalDatasource getUserLocalDatasource;

  setUp(() {
    saveLoginLocalDatasource = SaveLoginLocalDatasourceMock();
    getUserLocalDatasource = GetUserLocalDatasourceMock();
    userLocalRepository = UserLocalRepositoryImp(
      saveLoginLocalDatasource,
      getUserLocalDatasource,
    );
  });

  group('saveLoginLocal', () {
    test('should return UserLocalEntity', () async {
      when(() => saveLoginLocalDatasource(any(), any(), any()))
          .thenAnswer((_) async => true);

      final result =
          await userLocalRepository.saveLoginLocal('id', 'user', 'password');

      expect(result.fold(id, id), true);
    });

    test('should return UnableToSaveLoginLocal', () async {
      when(() => saveLoginLocalDatasource(any(), any(), any()))
          .thenThrow(UnableToSaveLoginLocal('error'));

      final result =
          await userLocalRepository.saveLoginLocal('id', 'user', 'password');

      expect(result.fold(id, id), isA<UnableToSaveLoginLocal>());
    });
  });
}
