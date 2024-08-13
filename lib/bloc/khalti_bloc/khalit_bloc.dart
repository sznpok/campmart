import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import '../../repo/khalti_repo.dart';
import 'khalit_event.dart';
import 'khalit_state.dart';

class KhaltiBloc extends Bloc<KhaltiEvent, KhaltiState> {
  final KhaltiRepository khaltiRepository;

  KhaltiBloc({required this.khaltiRepository}) : super(KhaltiInitial()) {
    on<StartPaymentEvent>(_onStartPayment);
  }

  void _onStartPayment(
      StartPaymentEvent event, Emitter<KhaltiState> emit) async {
    emit(PaymentProcessing());

    try {
      await khaltiRepository.makePayment(
        context: event.context,
        amount: event.amount,
        productIdentity: event.productIdentity,
        productName: event.productName,
        onSuccess: (PaymentSuccessModel success) {
          emit(PaymentSuccess(success.token));
        },
        onFailure: (PaymentFailureModel failure) {
          emit(PaymentFailure(failure.message));
        },
        onCancel: () {
          emit(PaymentCancelled());
        },
      );
    } catch (e) {
      emit(PaymentFailure(e.toString()));
    }
  }
}
