import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/services/networking.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({required this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  WeatherModel weather = WeatherModel();
  var temperature;
  String? weatherIcon;
  var cityName;
  String time = '';
  String celsiusDeg = '';
  String weatherMessage = '';
  Networking networking = Networking();

  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        cityName = 'No city';
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      weatherIcon = weather.getWeatherIcon(condition);
      celsiusDeg = temp.toStringAsFixed(2);
      time = weather.getMessage(temperature);
    });
  }

  Widget build(BuildContext buildContext) {
    return Scaffold(
        backgroundColor: Colors.black12,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.dstATop),
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.near_me,
                          size: 50.0,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          var result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return CityScreen();
                          }));
                          if (result != null){
                            var cityWeather = await networking.getWeatherCity(result);
                            updateUI(cityWeather);
                          }
                        },
                        child: Icon(
                          Icons.location_city,
                          size: 50.0,
                          color: Colors.white,
                        ),
                      )
                    ]),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "${celsiusDeg}°C",
                        style: kTempTextStyle,
                      ),
                      Text(
                        weatherIcon.toString(),
                        style: kConditionTextStyle,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "${time}",
                        style: kMessageTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "${cityName}",
                        style: kMessageTextStyle,
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
