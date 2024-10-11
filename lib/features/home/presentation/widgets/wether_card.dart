import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp/core/resources/colors.dart';
import 'package:travelapp/core/resources/dimens.dart';
import 'package:travelapp/features/home/presentation/cubit/cubit/location_cubit.dart';

class WeatherUpdateWidget extends StatefulWidget {
  const WeatherUpdateWidget({
    super.key,
  });

  @override
  State<WeatherUpdateWidget> createState() => _WeatherUpdateWidgetState();
}

class _WeatherUpdateWidgetState extends State<WeatherUpdateWidget> {
  @override
  void initState() {
    context.read<LocationCubit>().fetchWeatherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Dimens.defaultPadding),
      padding: const EdgeInsets.all(Dimens.defaultPadding),
      decoration: BoxDecoration(
        color: ApplicationColors(context).appWhiteBackground,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: BlocBuilder<LocationCubit, LocationState>(
        builder: (context, state) {
          if (state is LocationInitial) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
            );
          } else if (state is LocationSuccess) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.weather.cityName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        '${state.weather.temperature.round()}°',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                        ),
                      ),
                      Text(
                        state.weather.description,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
                // Weather icon
                Stack(
                  alignment: Alignment.center,
                  children: [
                    if (state.weather.icon.isEmpty)
                      const CircularProgressIndicator(),
                    if (state.weather.icon.isNotEmpty)
                      Image.network(
                        state.weather.icon,
                        width: 80.0,
                        height: 80.0,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                  ],
                )
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
