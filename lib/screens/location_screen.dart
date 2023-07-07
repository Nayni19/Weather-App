import 'package:climate_app/screens/city_screen.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import '../services/weather.dart';

class LocationScreen extends StatefulWidget {
  @override
  const LocationScreen({super.key, required this.locationWeather});
  final locationWeather;
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  WeatherModel weather = WeatherModel();
  String location = 'Error';
  String locationSubText = 'Cannot be fetched';
  String temperature = '0';
  String weatherCondtion = 'Unknown';
  String humidity = '0';
  String pressure = '0';
  String wind = '0';

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weather != null) {
        location = weatherData['name'].toString();
        locationSubText = 'Latitude / Longitude - ' +
            weatherData['coord']['lat'].toString() +
            ' / ' +
            weatherData['coord']['lon'].toString();
        temperature = weatherData['main']['temp'].toStringAsFixed(1) + '°';
        weatherCondtion =
            weatherData['weather'][0]['description'].toUpperCase();
        humidity = weatherData['main']['humidity'].toString();
        pressure = weatherData['main']['pressure'].toString();
        wind = weatherData['wind']['speed'].toString();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/weather_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () async {
                        var data = await weather.getLocationWeather();
                        updateUI(data);
                      },
                      child: Icon(
                        Icons.near_me,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        var result = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CityScreen(),
                          ),
                        );
                        if(result != null){
                          var weatherData = await weather.getCityLocation(result);
                          updateUI(weatherData);
                        }
                      },
                      child: Icon(
                        Icons.list,
                        size: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location,
                      style: kMessageTextStyle,
                    ),
                    Text(
                      locationSubText,
                      style: kweatherTabs,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      temperature,
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherCondtion,
                      style: kSubTitleTextStyle,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 2.0,
                      color: Colors.grey,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Humidity',
                                style: kweatherTabs,
                              ),
                              Text(
                                humidity,
                                style: kButtonTextStyle,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Pressure',
                                style: kweatherTabs,
                              ),
                              Text(
                                pressure,
                                style: kButtonTextStyle,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Wind',
                                style: kweatherTabs,
                              ),
                              Text(
                                wind,
                                style: kButtonTextStyle,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
