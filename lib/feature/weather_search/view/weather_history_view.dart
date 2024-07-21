import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/feature/weather_search/provider/weather_history_provider.dart';
import 'package:weather_app/utils/gaps.dart';
import 'package:weather_app/utils/images.dart';

import '../../../utils/temperature_utils.dart';

class WeatherHistoryView extends StatefulWidget {
  const WeatherHistoryView({super.key});

  @override
  State<WeatherHistoryView> createState() => _WeatherHistoryViewState();
}

class _WeatherHistoryViewState extends State<WeatherHistoryView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<WeatherHistoryProvider>().loadSavedWeatherData();
  }



  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    context.read<WeatherHistoryProvider>().clearVariable();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        title: const Text("Weather History"),
        actions: [
          Consumer<WeatherHistoryProvider>(
              builder: (context, weatherProvider, child) {
            return IconButton(
                onPressed: () {
                  weatherProvider.toggleFilterVisibility();
                },
                icon: Icon(
                  weatherProvider.isFilterVisible
                      ? Icons.filter_alt_rounded
                      : Icons.filter_alt_off_rounded,
                ));
          })
        ],
      ),
      body: Consumer<WeatherHistoryProvider>(
        builder: (context, weatherProvider, child) {
          if (weatherProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (weatherProvider.errorMessage.isNotEmpty) {
            return Text(weatherProvider.errorMessage);
          } else if (weatherProvider.weatherHistoryFilterResponse.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  if (weatherProvider.isFilterVisible)
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              // Initial Value
                              value: weatherProvider.filterValue,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: weatherProvider.filterList
                                  .map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),

                              onChanged: (String? newValue) {
                                weatherProvider.setDropDownValue(newValue!);
                              },
                            ),
                          ),
                        ),
                        20.hGap,
                        TextField(
                          controller: weatherProvider.filterController,
                          onChanged: (value) {
                            weatherProvider.setFilter(value);
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter city name',
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                weatherProvider.setFilter(
                                    weatherProvider.filterController.text);
                              },
                              icon: const Icon(Icons.search),
                            ),
                          ),
                        ),
                        20.hGap,
                      ],
                    ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            weatherProvider.weatherHistoryFilterResponse.length,
                        itemBuilder: (context, index) => Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16))),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${TemperatureUtils.kelvinToCelsius(weatherProvider.weatherHistoryFilterResponse[index].weatherData?.main?.temp ?? 0.0)}°',
                                        style: const TextStyle(
                                          fontSize: 38,
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  'H: ${TemperatureUtils.kelvinToCelsius(weatherProvider.weatherHistoryFilterResponse[index].weatherData?.main?.tempMax ?? 0.0)}°',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                            TextSpan(
                                              text:
                                                  ' L: ${TemperatureUtils.kelvinToCelsius(weatherProvider.weatherHistoryFilterResponse[index].weatherData?.main?.tempMin ?? 0.0)}°',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Image.asset(
                                        Images.getWeatherIconPath(weatherProvider
                                                .weatherHistoryFilterResponse[
                                                    index]
                                                .weatherData
                                                ?.weather?[0]
                                                .icon ??
                                            ""),
                                        height: 80,
                                        width: 80,
                                        cacheHeight: 80,
                                        cacheWidth: 80,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              20.hGap,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    (weatherProvider
                                            .weatherHistoryFilterResponse[index]
                                            .city ??
                                        ""),
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    (weatherProvider
                                            .weatherHistoryFilterResponse[index]
                                            .weatherData
                                            ?.weather?[0]
                                            .main ??
                                        ""),
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Text('No weather data');
          }
        },
      ),
    );
  }
}
