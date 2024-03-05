import 'package:get_it/get_it.dart';
import 'package:weather_app/data/repositories/weather_repository.dart';
import 'package:weather_app/modules/home/cubit/home_cubit.dart';

T get<T extends Object>() => GetIt.I<T>();

void registerSingleton<T extends Object>(T dependency) =>
    GetIt.I.registerSingleton<T>(dependency);

void registerFactory<T extends Object>(T Function() builder) =>
    GetIt.I.registerFactory(builder);

Future<void> initDI() async {
  registerFactory(WeatherRepository.new);
  registerSingleton(HomeCubit());
}
