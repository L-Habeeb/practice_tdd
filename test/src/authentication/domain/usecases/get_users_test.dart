import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:practice_tdd/src/authentication/domain/entities/user.dart';
import 'package:practice_tdd/src/authentication/domain/repositories/auth_repository.dart';
import 'package:practice_tdd/src/authentication/domain/usecases/get_users.dart';

import 'authentication_repository.mock.dart';


void main() {
  late GetUser usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    usecase = GetUser(repository);
  });

  // Create fake user data for testing
  final tUsers = [User.empty()];

  test('should call the AuthRepo.getUsers and retun list', () async {
    // Arrange
    when(() => repository.getUser())
        .thenAnswer((_) async => Right(tUsers));

    // Act
    final result = await usecase();

    // Assert
    expect(result, equals(Right<dynamic, List<User>>(tUsers)));
    
    // Verify repository.getUsers was called once
    verify(() => repository.getUser()).called(1);
    
    // Make sure nothing else was called
    verifyNoMoreInteractions(repository);
  });
}