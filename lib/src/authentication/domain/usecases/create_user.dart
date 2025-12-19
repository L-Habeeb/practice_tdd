import 'package:equatable/equatable.dart';
import 'package:practice_tdd/core/usecase/usecase.dart';
import 'package:practice_tdd/core/utils/typedef.dart';
import 'package:practice_tdd/src/authentication/domain/repositories/auth_repository.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  // Expects an ImplementationAuthenticationRepository
  const CreateUser(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultVoid call(CreateUserParams params) async =>
      _repository.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar,
      );

  // ImplementationAuthenticationRepository as createUser which requires
  // createdAt, name, avatar,

}


class CreateUserParams extends Equatable {
  const CreateUserParams({
    required this.createdAt,
    required this.name,
    required this.avatar,
  });
  
  final String createdAt;
  final String name;
  final String avatar;

  const CreateUserParams.empty() : this(
    createdAt: '_empty.createdAt',
    name: '_empty.name',
    avatar: '_empty.avatar',
  );
  
  @override
  List<Object?> get props => [name, createdAt, avatar];

}
