import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp/core/services/location/location_services.dart';
import 'package:travelapp/core/services/remote_services/location_remote_services.dart';
import 'package:travelapp/features/home/data/model/wether_model.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final LocationServices locationServices = LocationServices();
  final LocationRemoteServices locationRemoteServices =
      LocationRemoteServices();

  LocationCubit() : super(const LocationInitial());

  void fetchWeatherData() async {
    emit(const LocationInitial());

    final locationData = await locationServices.getCurrentLocation();
    if (locationData != null) {
      final weatherData =
          await locationRemoteServices.fetchWeatherByCurrentLocation(
              locationData.latitude!, locationData.longitude!);
      if (weatherData != null) {
        Weather weather = weatherData;

        emit(LocationSuccess(weather: weather));
      }
    }
  }
}
