import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/modules/details/details_screen.dart';
import 'package:weather_app/modules/home/cubit/home_cubit.dart';

import '../../core/di/dependency_provider.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> cities = [
    'Львів',
    'Одеса',
    'Київ',
    'Кривий Ріг',
    'Харків',
    'Херсон'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
                itemCount: cities.length,
                itemBuilder: (context, i) => buildCityItem(cities[i])),
          ),
        ],
      ),
    );
  }

  Widget buildCityItem(String city) {
    return GestureDetector(
      onTap: () {
        _navigateAndDisplayWeather(context, city);
      },
      child: Card(
        color: const Color(0xFFF1F4F9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        child: SizedBox(
          child: Container(
            height: 60.0,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeCityChosen) {
                      if (state.city != city) {
                        return Container();
                      }
                      final weather = state.weather;
                      final temp =
                          weather.temperature?.celsius?.ceil().toString() ?? '';
                      final icon = weather.weatherIcon ?? '';
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('$temp°C', style: const TextStyle(fontSize: 16.0)),
                          icon != ''
                              ? Image.network(
                                  'http://openweathermap.org/img/w/$icon.png')
                              : Container(),
                          const SizedBox(
                            height: 54.0,
                            child: VerticalDivider(
                              width: 20.0,
                              thickness: 2.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
                Text(city),
                const SizedBox(width: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _navigateAndDisplayWeather(
      BuildContext context, String city) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailsScreen(city: city)),
    );
    get<HomeCubit>().highlightCity(city, result);
  }
}
