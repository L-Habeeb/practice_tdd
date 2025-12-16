import 'package:practice_tdd/core/utils/typedef.dart';
import 'package:practice_tdd/src/authentication/domain/repositories/auth_repository.dart';

class CreateUser {
  final AuthenticationRepository _repository;

  CreateUser(this._repository);

  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async =>
      _repository.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );
}
