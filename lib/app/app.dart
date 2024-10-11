import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelapp/features/common/cubit/connectivity_cubit/connectivity_cubit.dart';
import 'package:travelapp/features/home/presentation/cubit/cubit/location_cubit.dart';
import 'package:travelapp/features/home/presentation/cubit/cubit/page_indicator_cubit.dart';

import 'package:travelapp/routes/routes.dart' as router;

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final Connectivity connectivity = Connectivity();

  @override
  void initState() {
    // Observe app state
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // save AppInstance()
    } else if (state == AppLifecycleState.resumed) {
    } else if (state == AppLifecycleState.inactive) {
      // save AppInstance()
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // save AppInstance()
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectivityCubit>(
          create: (context) => ConnectivityCubit(connectivity: connectivity),
        ),
        BlocProvider<PageIndicatorCubit>(
          create: (context) => PageIndicatorCubit(),
        ),
        BlocProvider<LocationCubit>(
          create: (context) => LocationCubit(),
        ),
      ],
      child: const MaterialApp(
        title: 'Camms.Incident',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router.Router.generateRoute,
        initialRoute: router.ScreenRoutes.toSplashScreen,
      ),
    );
  }
}
