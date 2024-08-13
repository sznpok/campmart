import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class KhaltiEvent extends Equatable {
  const KhaltiEvent();

  @override
  List<Object?> get props => [];
}

class StartPaymentEvent extends KhaltiEvent {
  final int amount;
  final String productIdentity;
  final String productName;
  final BuildContext context;

  const StartPaymentEvent({
    required this.amount,
    required this.productIdentity,
    required this.productName,
    required this.context,
  });

  @override
  List<Object?> get props => [amount, productIdentity, productName, context];
}
