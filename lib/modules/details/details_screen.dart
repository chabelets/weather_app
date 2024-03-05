import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/dependency_provider.dart';
import 'cubit/details_cubit.dart';

class DetailsScreen extends StatefulWidget {
  final String city;

  const DetailsScreen({super.key, required this.city});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsCubit(get())..getWeather(widget.city),
      child: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (context, state) {
          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) async {
              if (didPop) return;
              if (state is DetailsLoaded) {
                Navigator.of(context).pop(state.weather);
              }
            },
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  title: Text(widget.city),
                ),
                body: BlocBuilder<DetailsCubit, DetailsState>(
                  builder: (context, state) {
                    if (state is DetailsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is DetailsLoaded) {
                      final weather = state.weather;
                      final temp =
                          weather.temperature?.celsius?.ceil().toString() ?? '';
                      final icon = weather.weatherIcon ?? '';
                      return Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('$temp°C',
                                style: const TextStyle(fontSize: 16.0)),
                            icon != ''
                                ? Image.network(
                                    'http://openweathermap.org/img/w/$icon.png')
                                : Container(),
                          ],
                        ),
                      );
                    }
                    return Container();
                  },
                )),
          );
        },
      ),
    );
  }
}
