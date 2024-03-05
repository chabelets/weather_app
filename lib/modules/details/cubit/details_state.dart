part of 'details_cubit.dart';

@immutable
abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class DetailsLoading extends DetailsState {}

final class DetailsLoaded extends DetailsState {
  final Weather weather;

  DetailsLoaded(this.weather);
}

