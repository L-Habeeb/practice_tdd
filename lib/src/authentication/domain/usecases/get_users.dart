import 'package:practice_tdd/core/usecase/usecase.dart';
import 'package:practice_tdd/core/utils/typedef.dart';
import 'package:practice_tdd/src/authentication/domain/entities/user.dart';
import 'package:practice_tdd/src/authentication/domain/repositories/auth_repository.dart';

class GetUser extends UsecaseWithoutParams<List<User>> {
  GetUser(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<List<User>> call() async => _repository.getUser();
}

