import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(this.message, this.statusCode);

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, super.statusCode);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message, super.statusCode);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message, super.statusCode);
}
