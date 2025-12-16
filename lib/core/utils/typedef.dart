import 'package:dartz/dartz.dart';
import 'package:practice_tdd/core/errors/failure.dart';

typedef ResultFuture<T> = Future<Either<Failures, T>>;

typedef ResultVoid = ResultFuture<void>;

