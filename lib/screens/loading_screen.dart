import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    _getData();
    super.initState();
  }

  void _getData() async {

    Networking networking = Networking();
    var w = await networking.getWeatherLocation();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));


    Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context){
      return LocationScreen(locationWeather: w);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SpinKitDoubleBounce(
            color: Colors.blue,
            size: 150,
          ),
        )
    );
  }
}
