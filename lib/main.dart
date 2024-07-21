import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/feature/weather_search/provider/weather_history_provider.dart';
import 'package:weather_app/feature/weather_search/provider/weather_search_provider.dart';
import 'package:weather_app/feature/weather_search/view/weather_search_view.dart';
import 'package:weather_app/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Create instances of WeatherSearchProvider and WeatherHistoryProvider
        ChangeNotifierProvider<WeatherSearchProvider>(create: (_) => WeatherSearchProvider()),
        ChangeNotifierProvider<WeatherHistoryProvider>(create: (_) => WeatherHistoryProvider()),
      ],
      child: MaterialApp(
        title: 'Weather',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const WeatherSearchView(),
      ),
    );
  }
}


