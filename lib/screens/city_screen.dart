import 'package:flutter/material.dart';
import '../utilities/constants.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jfif'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                  decoration: ktextInputStyle,
                  onChanged: (value) => cityName = value,
                ),
              ),
              TextButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();

                  await Future.delayed(const Duration(milliseconds: 1000));
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context, cityName);
                },
                style: TextButton.styleFrom(
                    // backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(15.0)),
                child: const Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
