import 'package:equatable/equatable.dart';

abstract class KhaltiState extends Equatable {
  const KhaltiState();

  @override
  List<Object?> get props => [];
}

class KhaltiInitial extends KhaltiState {}

class PaymentProcessing extends KhaltiState {}

class PaymentSuccess extends KhaltiState {
  final String token;

  const PaymentSuccess(this.token);

  @override
  List<Object?> get props => [token];
}

class PaymentFailure extends KhaltiState {
  final String error;

  const PaymentFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class PaymentCancelled extends KhaltiState {}
