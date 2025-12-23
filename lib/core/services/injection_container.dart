// sl = Service Locator
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../src/authentication/data/datasources/authentication_remote_data_source.dart';
import '../../src/authentication/data/repositories/auth_repository_implementation.dart';
import '../../src/authentication/domain/repositories/auth_repository.dart';
import '../../src/authentication/domain/usecases/create_user.dart';
import '../../src/authentication/domain/usecases/get_users.dart';
import '../../src/authentication/presentation/cubit/authentication_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    // App Logic
    ..registerFactory(
      () => AuthenticationCubit(createUser: sl(), getUsers: sl()),
    )
    // Use cases
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUser(sl()))
    // Repositories
    ..registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImplementation(sl()),
    )
    // Data Source
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()),
    )
    // External Dependencies
    ..registerLazySingleton(http.Client.new);
}
