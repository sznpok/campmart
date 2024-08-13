part of 'home_page_bloc.dart';

sealed class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

final class HomePageClickEvent extends HomePageEvent {
  final int id;

  const HomePageClickEvent({required this.id});

  @override
  List<Object> get props => [id];
}
