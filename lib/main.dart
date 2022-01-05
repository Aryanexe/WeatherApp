import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './weatherapp.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/getWeather.dart';
import 'package:flutter/cupertino.dart';
import 'models.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _cityTextController = TextEditingController();

  final _dataService = DataService();

  late WeatherResponse _response;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Forecast',
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Weather'),
          centerTitle: true,
          /*actions: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: SvgPicture.asset('assets/Menu.svg',
            height: 30,
              width: 30,
              color: Colors.white,
            ),
          ),
        ],*/
        ),
        body: Container(
          child: Stack(
            children: [
              Image.asset('assets/Night.webp',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
              Container(
                decoration: BoxDecoration(color: Colors.black38),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                      child: Row(
                        children: [
                          Container(
                            width: 150,
                            child: TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white70,
                                border: OutlineInputBorder(),
                                labelText: 'Search',
                                hintText: 'City',
                                prefixIcon: Icon(Icons.star),
                              ),
                            ),
                          ),

                          IconButton(
                            onPressed: () {
                              _search();
                            },
                            icon: Icon(Icons.search,
                                color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    if(_response != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            '${_response.tempInfo.temperature} degrees',
                            style: GoogleFonts.lato(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            _response.weatherInfo.description,
                            style: GoogleFonts.lato(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(() {
      _response = response;
    });
  }
}


