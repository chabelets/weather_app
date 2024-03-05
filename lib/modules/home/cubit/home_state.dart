part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeCityChosen extends HomeState {
  final String city;
  final Weather weather;

  HomeCityChosen(this.city, this.weather);
}
