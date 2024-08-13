import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_page_event.dart';

part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(Page1()) {
    on<HomePageClickEvent>(_homeClickEvent);
  }

  FutureOr<void> _homeClickEvent(
      HomePageClickEvent event, Emitter<HomePageState> emit) {
    switch (event.id) {
      case 0:
        emit(Page1());
        break;
      case 1:
        emit(Page2());
        break;
      case 2:
        emit(Page3());
        break;
      case 3:
        emit(Page4());
        break;
      default:
        emit(Page1());
    }
  }
}
