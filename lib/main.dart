import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_tdd_app/presentation/bloc/weather/bloc.dart';
import 'package:weather_tdd_app/presentation/injection_container.dart';
import 'package:weather_tdd_app/presentation/pages/weather_page.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator<WeatherBloc>(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: WeatherPage(),
      ),
    );
  }
}
