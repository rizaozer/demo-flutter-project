import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const MyHomePage(title: 'Daily Weather'),
        debugShowCheckedModeBanner: false
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String countryName="Estonia";
  String cityName = "Tallinn";
  String degree = "0";
  String apikey = "8807f7f3df3d41472802ba060f3f7e8f";

  showWeather() async{
    String url = "http://api.openweathermap.org/data/2.5/weather?q=$cityName,$countryName&units=metric&appid="+apikey;
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      var items = jsonDecode(response.body);

      setState((){
        degree = (items["main"]["temp"]).round().toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'riza',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),

      bottomNavigationBar: Material(
        color: Colors.green,
        child: InkWell(
          onTap: () {
          },
          child: const SizedBox(
            height: kToolbarHeight,
            width: double.infinity,
            child: Center(
              child: Text(
                'Refresh',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
