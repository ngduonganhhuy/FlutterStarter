import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aes_room/core/impl/base_page.dart';
import 'package:aes_room/injection_container.dart';
import 'package:aes_room/presentation/bloc/weather/weather_bloc.dart';

class WeatherPage extends StatefulWidget implements BasePage {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();

  @override
  String get screenName => 'WeatherPage';
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<WeatherBloc>(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff1D1E22),
          title: const Text(
            'WEATHER',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter city name',
                  fillColor: const Color(0xffF3F3F3),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (query) {
                  locator<WeatherBloc>().add(OnCityChanged(query));
                },
              ),
              const SizedBox(height: 32),
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is WeatherLoaded) {
                    return Column(
                      key: const Key('weather_data'),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.result?.name ?? '',
                              style: const TextStyle(
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Table(
                          defaultColumnWidth: const FixedColumnWidth(150),
                          border: TableBorder.all(
                            color: Colors.grey,
                          ),
                          children: [
                            TableRow(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Temperature',
                                    style: TextStyle(
                                      fontSize: 16,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    state.result?.main?.temp?.toString() ?? '',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      letterSpacing: 1.2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ), // Will be change later
                              ],
                            ),
                            TableRow(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Pressure',
                                    style: TextStyle(
                                      fontSize: 16,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    state.result?.main?.pressure.toString() ?? '',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      letterSpacing: 1.2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ), // Will be change later
                              ],
                            ),
                            TableRow(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Humidity',
                                    style: TextStyle(
                                      fontSize: 16,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    state.result?.main?.humidity.toString() ?? '',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      letterSpacing: 1.2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ), // Will be change later
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  if (state is WeatherLoadFailue) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
