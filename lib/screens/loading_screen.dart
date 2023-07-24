import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import './location_screen.dart';
import '../services/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    var weatherData = await WeatherModel().getLocationWeather();
    Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => LocationScreen(locationWeather: weatherData),
    ),
  );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitFadingFour(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}

// double temp = jsonDecode(data)['main']['temp'];
// int status = jsonDecode(data)['weather'][0]['main'];
// String city = jsonDecode(data)['name'];