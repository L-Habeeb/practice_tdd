import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {
  final String message;
  final int statusCode;

  const Failures({required this.message, required this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}


class ApiFailures extends Failures {
  const ApiFailures({required super.message, required super.statusCode});
}

