// What does the class depends on
// Ans: AuthenticationRepository
// How can we create a version of the Dependecy
// Ans: Mocktail
// How do we control what our dependecies do
// Ans: Using the Mocktails's API

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:practice_tdd/src/authentication/domain/repositories/auth_repository.dart';
import 'package:practice_tdd/src/authentication/domain/usecases/create_user.dart';

import 'authentication_repository.mock.dart';


void main() {
  late CreateUser usecase;
  late AuthenticationRepository repository;

  //  setUp runs before each Test
  setUp(() {
    repository = MockAuthRepo();
    usecase = CreateUser(repository);
  });
  const params = CreateUserParams.empty();

  test('should call the AuthRepo.createuser', () async {
    // Arrange
    // STUB
    when(
      () => repository.createUser(
        createdAt: any(named: 'createdAt'),
        name: any(named: 'name'),
        avatar: any(named: 'avatar'),
      ),
    ).thenAnswer((_) async => const Right(null));

    // ACT
    final result = await usecase(params);

    // Assert
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(
      () => repository.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar,
      ),
    ).called(1);

    verifyNoMoreInteractions(repository);
  });
}
