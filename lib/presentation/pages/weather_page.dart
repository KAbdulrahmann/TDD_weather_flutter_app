import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_tdd_app/core/constants/constants.dart';
import 'package:weather_tdd_app/presentation/bloc/weather/bloc.dart';
import 'package:weather_tdd_app/presentation/bloc/weather/event.dart';
import 'package:weather_tdd_app/presentation/bloc/weather/state.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather',
        ),
        centerTitle: true,
        backgroundColor: Color(0xff1d1e22),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'enter city name',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10))),
              onChanged: (value) {
                context.read<WeatherBloc>().add(OnCityChanged(value));
              },
            ),
            SizedBox(
              height: 40,
            ),
            BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
              if (state is WeatherLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is WeatherLoaded) {
                return Column(
                  key: const Key('weather_data'),
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.result.cityName),
                        Image(
                            image: NetworkImage(
                                Urls.weatherIcon(state.result.iconCode))),
                      ],
                    ),
                    Text('${state.result.main} | ${state.result.description}'),
                    SizedBox(
                      height: 24,
                    ),
                    Table(
                      defaultColumnWidth: FixedColumnWidth(150),
                      border: TableBorder.all(
                          color: Colors.grey,
                          style: BorderStyle.solid,
                          width: 1),
                      children: [
                        TableRow(children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text('Temprature'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(state.result.temperature.toString()),
                          ),
                        ]),
                        TableRow(children: [
                          const Padding(
                            padding: EdgeInsets.all(8),
                            child: Text('Pressure'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(state.result.pressure.toString()),
                          ),
                        ]),
                        TableRow(children: [
                          const Padding(
                            padding: EdgeInsets.all(8),
                            child: Text('Humidity'),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(state.result.humidity.toString()),
                          ),
                        ]),
                      ],
                    )
                  ],
                );
              }
              if (state is WeatherLoadFailue) {
                return Center(
                  child: Text(state.message),
                );
              }
              return Container();
            })
          ],
        ),
      ),
    );
  }
}
