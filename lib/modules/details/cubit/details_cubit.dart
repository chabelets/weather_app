import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/data/repositories/weather_repository.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  final WeatherRepository _weatherRepository;

  DetailsCubit(this._weatherRepository) : super(DetailsInitial());

  Future<void> getWeather(String city) async {
    emit(DetailsLoading());
    final weather = await _weatherRepository.getWeather(city);
    if (weather != null) {
      emit(DetailsLoaded(weather));
    }
  }
}
