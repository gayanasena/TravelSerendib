// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:travelapp/core/resources/colors.dart';
// import 'package:travelapp/core/resources/dimens.dart';
// import 'package:travelapp/features/home/presentation/cubit/cubit/location_cubit.dart';
// import 'package:weather/weather.dart';

// class WeatherUpdateWidget extends StatefulWidget {
//   const WeatherUpdateWidget({
//     super.key,
//   });

//   @override
//   State<WeatherUpdateWidget> createState() => _WeatherUpdateWidgetState();
// }

// enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }

// class _WeatherUpdateWidgetState extends State<WeatherUpdateWidget> {
//     String key = '856822fd8e22db5e1ba48c0e7d69844a';
//   late WeatherFactory ws;
//   List<Weather> _data = [];
//   AppState _state = AppState.NOT_DOWNLOADED;
//   double? lat, lon;

//   @override
//   void initState() {
//     context.read<LocationCubit>().fetchWeatherData();
//     super.initState();
//   }

//   void queryForecast() async {
//     /// Removes keyboard
//     FocusScope.of(context).requestFocus(FocusNode());
//     setState(() {
//       _state = AppState.DOWNLOADING;
//     });

//     List<Weather> forecasts = await ws.fiveDayForecastByLocation(lat!, lon!);
//     setState(() {
//       _data = forecasts;
//       _state = AppState.FINISHED_DOWNLOADING;
//     });
//   }

//   void queryWeather() async {
//     /// Removes keyboard
//     FocusScope.of(context).requestFocus(FocusNode());

//     setState(() {
//       _state = AppState.DOWNLOADING;
//     });

//     Weather weather = await ws.currentWeatherByLocation(lat!, lon!);
//     setState(() {
//       _data = [weather];
//       _state = AppState.FINISHED_DOWNLOADING;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(Dimens.defaultPadding),
//       padding: const EdgeInsets.all(Dimens.defaultPadding),
//       decoration: BoxDecoration(
//         color: ApplicationColors(context).appWhiteBackground,
//         borderRadius: BorderRadius.circular(12.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             offset: const Offset(0, 2),
//             blurRadius: 4.0,
//           ),
//         ],
//       ),
//       child: BlocBuilder<LocationCubit, LocationState>(
//         builder: (context, state) {
//           if (state is LocationInitial) {
//             return const Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: CircularProgressIndicator(),
//                   ),
//                 ],
//               ),
//             );
//           } else if (state is LocationSuccess) {
//             double? tempdou = state.weather.main?.temp ?? 0;

//             int temp = tempdou.round();
//             return Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         state.weather.name ?? "",
//                         style: const TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16.0,
//                         ),
//                       ),
//                       Text(
//                         '$temp°',
//                         style: const TextStyle(
//                           color: Colors.black,
//                           fontSize: 24.0,
//                         ),
//                       ),
//                       Text(
//                         state.weather.weather.first?.description ?? "",
//                         style: const TextStyle(
//                           color: Colors.black,
//                           fontSize: 14.0,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Weather icon
//                 Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     if (state.weather.weather.first!.icon!.isEmpty)
//                       const CircularProgressIndicator(),
//                     if (state.weather.weather.first!.icon!.isNotEmpty)
//                       Image.network(
//                         'https://openweathermap.org/img/w/${state.weather.weather.first!.icon}.png',
//                         width: 80.0,
//                         height: 80.0,
//                         fit: BoxFit.cover,
//                         loadingBuilder: (BuildContext context, Widget child,
//                             ImageChunkEvent? loadingProgress) {
//                           if (loadingProgress == null) {
//                             return child;
//                           } else {
//                             return const CircularProgressIndicator();
//                           }
//                         },
//                       ),
//                   ],
//                 )
//               ],
//             );
//           } else {
//             return Container();
//           }
//         },
//       ),
//     );
//   }
// }
