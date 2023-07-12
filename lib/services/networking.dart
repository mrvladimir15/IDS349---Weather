import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clima/services/location.dart';

class Networking {
  //final String url;
  //a66f87f65a34a6146d8912bee55dcbb7
  // 'https://api.openweathermap.org/data/3.0/onecall?lat={lat}&lon={lon}&exclude={part}&appid=a66f87f65a34a6146d8912bee55dcbb7'

  Future<dynamic> getWeatherLocation() async {
    Location location = Location();
    await location.getLocation();

      var url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=a66f87f65a34a6146d8912bee55dcbb7&units=metric');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body.toString());
      }
  }

  Future<dynamic> getWeatherCity(String? cityName) async {
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=a66f87f65a34a6146d8912bee55dcbb7&units=metric");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body.toString());
    }
  }
}
