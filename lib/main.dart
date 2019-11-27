import 'dart:convert';
import './keys.dart';
import 'package:flutter/material.dart';
import 'models/WeatherData.dart';
import 'models/ForecastData.dart';
import 'package:http/http.dart' as http;
import 'widgets/Weather.dart';
import 'widgets/WeatherItem.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Hello World!',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainPage()
    );
  }
}

class MainPage extends StatefulWidget{
  MainPage({Key key}) : super(key: key);

  @override
  _MainPage createState() => _MainPage();

}

class _MainPage extends State<MainPage>{

  bool isLoading = false;
  WeatherData weatherData;
  ForecastData forecastData;

  @override
  void initState() {
    super.initState();

    loadWeather(1819729);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Text('Flutter Weather App'),
        ),
        body: Center(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 50.0, bottom: 10.0),
                              child: weatherData != null
                                  ? Weather(weather: weatherData)
                                  : Container(),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 200.0,
                        child: forecastData != null
                            ? ListView.builder(
                            itemCount: forecastData.list.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => WeatherItem(
                                weather:
                                forecastData.list.elementAt(index)))
                            : Container(),
                      ),
                    ),
                  ),

                ]
            )
        ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _displayDialog(context),
        label: Text('Select City'),
        icon: Icon(Icons.language),
        backgroundColor: Colors.blue,
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }

  final List<int> countryMapping = [1819729, 1857910, 7839805, 5128638, 1835848, 1880252, 6160752, 1668341, 1850147, 6167865];
  final List<String> _dropdownValues = ['Hong Kong', 'Kyoto', 'Melbourne', 'New York', 'Seoul', 'Singapore', 'Sydney', 'Taipei', 'Tokyo', 'Toronto'];

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Select a City'),
            /* 1 */
            content: DropdownButton(
              items: _dropdownValues
                  .map((value) => DropdownMenuItem(
                child: Text(value),
                value: value,
              ))
                  .toList(),
              onChanged: (String value) {
                int index = _dropdownValues.indexOf(value);
                loadWeather(countryMapping[index]);
                Navigator.of(context).pop(countryMapping[index]);
              },
              isExpanded: false,
              hint: Text('City Name'),
            ),
            /* 2 */
            actions: <Widget>[
              new FlatButton(
                child: new Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }

  loadWeather(var cID) async {
    setState(() {
      isLoading = true;
    });

    Map<String, double> location;

    final cityID = cID;//Desired city
    final appID = getApiKey();

    final weatherResponse = await http.get(
        'http://api.openweathermap.org/data/2.5/weather?id=${cityID.toString()}&units=metric&appid=${appID.toString()}'
    );

    final forecastResponse = await http.get(
        'http://api.openweathermap.org/data/2.5/forecast?id=${cityID.toString()}&units=metric&appid=${appID.toString()}'
    );

    if (weatherResponse.statusCode == 200 &&
        forecastResponse.statusCode == 200) {
      return setState(() {
        weatherData = new WeatherData.fromJson(jsonDecode(weatherResponse.body));
        forecastData = new ForecastData.fromJson(jsonDecode(forecastResponse.body));
        isLoading = false;
      });
    }

    setState(() {
      isLoading = false;
    });
  }
}