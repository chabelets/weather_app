import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather/weather.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> highlightCity(String city, Weather weather) async =>
      emit(HomeCityChosen(city, weather));
}
