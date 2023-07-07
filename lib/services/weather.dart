import '../services/location.dart';
import '../services/networking.dart';
import '../api.dart';

class WeatherModel {
  double lat = 0.0;
  double long = 0.0;

  Future<dynamic> getCityLocation(String city) async {
    NetworkingData networkingData = NetworkingData(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=$apikey&units=metric');
    var weatherData = await networkingData.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    lat = location.latitude;
    long = location.longitude;
    NetworkingData networkingData = NetworkingData(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&APPID=$apikey&units=metric');
    var weatherData = await networkingData.getData();
    return weatherData;
  }
}
