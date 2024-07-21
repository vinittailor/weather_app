import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/feature/weather_search/provider/weather_search_provider.dart';
import 'package:weather_app/feature/weather_search/view/weather_history_view.dart';
import 'package:weather_app/utils/constant.dart';
import 'package:weather_app/utils/gaps.dart';
import 'package:weather_app/utils/images.dart';
import 'package:weather_app/utils/temperature_utils.dart';

class WeatherSearchView extends StatefulWidget {
  const WeatherSearchView({super.key});

  @override
  State<WeatherSearchView> createState() => _WeatherSearchViewState();
}

class _WeatherSearchViewState extends State<WeatherSearchView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<WeatherSearchProvider>().findCurrentLocation(context);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        showExitPop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          foregroundColor: Colors.white,
          title: const Text("Weather"),
          actions: [
            IconButton(
                onPressed: () {
                  navigateToNextPage(context, const WeatherHistoryView());
                },
                icon: const Icon(Icons.history_rounded))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller:
                      context.read<WeatherSearchProvider>().cityController,
                  decoration: InputDecoration(
                      hintText: 'Enter city name',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            context
                                .read<WeatherSearchProvider>()
                                .findLocationFromCity(context);
                          },
                          icon: const Icon(Icons.search))),
                ),
                20.hGap,
                Consumer<WeatherSearchProvider>(
                  builder: (context, weatherProvider, child) {
                    if (weatherProvider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (weatherProvider.errorMessage.isNotEmpty) {
                      return SizedBox(
                        height: 500,
                        child: Center(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(weatherProvider.errorMessage),
                            TextButton(onPressed: () => weatherProvider.findLocationFromCity(context), child: const Text("Retry")),
                          ],
                        )),
                      );
                    } else if (weatherProvider.weatherSearchResponse != null) {
                      return SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${weatherProvider.weatherSearchResponse!.name}',
                              style: const TextStyle(
                                  fontSize: 38, fontWeight: FontWeight.w300),
                            ),
                            40.hGap,
                            Image.asset(
                              Images.getWeatherIconPath(weatherProvider
                                      .weatherSearchResponse!
                                      .weather?[0]
                                      .icon ??
                                  ""),
                              height: 80,
                              width: 80,
                              cacheHeight: 80,
                              cacheWidth: 80,
                            ),
                            10.hGap,
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        '${TemperatureUtils.kelvinToCelsius(weatherProvider.weatherSearchResponse?.main?.temp ?? 0.0)}°',
                                    style: const TextStyle(
                                        fontSize: 38,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  TextSpan(
                                    text: (weatherProvider.weatherSearchResponse
                                            ?.weather?[0].main ??
                                        ""),
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        'H: ${TemperatureUtils.kelvinToCelsius(weatherProvider.weatherSearchResponse?.main?.tempMax ?? 0.0)}°',
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                  TextSpan(
                                    text:
                                        ' L: ${TemperatureUtils.kelvinToCelsius(weatherProvider.weatherSearchResponse?.main?.tempMin ?? 0.0)}°',
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            20.hGap,
                            Row(
                              children: [
                                Expanded(
                                  child: _buildWeatherCardWidget(
                                    img: Images.temperatureBlack,
                                    title: 'Feel like',
                                    value:
                                        '${TemperatureUtils.kelvinToCelsius(weatherProvider.weatherSearchResponse?.main?.feelsLike ?? 0.0)}°',
                                  ),
                                ),
                                20.wGap,
                                Expanded(
                                  child: _buildWeatherCardWidget(
                                      img: Images.windBlack,
                                      title: 'Wind',
                                      value:
                                          '${TemperatureUtils.metersPerSecondToMilesPerHour(weatherProvider.weatherSearchResponse?.wind?.speed ?? 0.0)}',
                                      valueType: "  mi/h"),
                                ),
                              ],
                            ),
                            20.hGap,
                            Row(
                              children: [
                                Expanded(
                                  child: _buildWeatherCardWidget(
                                      img: Images.humidityBlack,
                                      title: 'Humidity',
                                      value: (weatherProvider
                                              .weatherSearchResponse
                                              ?.main
                                              ?.humidity
                                              .toString() ??
                                          "0.0"),
                                      valueType: "%"),
                                ),
                                20.wGap,
                                Expanded(
                                  child: _buildWeatherCardWidget(
                                      img: Images.visibilityBlack,
                                      title: 'Visibility',
                                      value:
                                          '${(weatherProvider.weatherSearchResponse?.visibility ?? 0.0) / 1000}',
                                      valueType: "  km"),
                                ),
                              ],
                            ),
                            20.hGap,
                            SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                  onPressed: () {
                                    weatherProvider.saveWeatherData(context);
                                  },
                                  style: ButtonStyle(
                                      foregroundColor:
                                          WidgetStateProperty.all<Color>(
                                              Colors.white),
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                              Colors.deepPurpleAccent),
                                      shape: WidgetStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ))),
                                  child: const Text(
                                    "Save",
                                    style: TextStyle(fontSize: 16),
                                  )),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Center(child: Text('No weather data'));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildWeatherCardWidget({
    required String img,
    required String title,
    required String value,
    String valueType = "",
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            img,
            height: 25,
            width: 25,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: const TextStyle(fontSize: 28, color: Colors.black),
                ),
                TextSpan(
                  text: valueType,
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
