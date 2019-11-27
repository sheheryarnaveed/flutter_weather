import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/WeatherData.dart';


class Weather extends StatelessWidget {

  final WeatherData weather;
  Weather({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 5.0),
                child: Text(weather.name,
                    style: new TextStyle(color: Colors.white, fontSize: 32.0)),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                child: Text(weather.main,
                    style: new TextStyle(color: Colors.white, fontSize: 16.0)),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                child: Text('${weather.temp.round().toString()}°C',
                    style: new TextStyle(color: Colors.white, fontSize: 48.0)),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Wrap(
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 10,
              runSpacing: 10,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: Text('${DateFormat('EEEE').format(DateTime.now())}',
                      style:
                      new TextStyle(color: Colors.white, fontSize: 16.0)),
                ),
                Container(
                  child: Text('TODAY',
                      style:
                      new TextStyle(color: Colors.white, fontSize: 16.0)),
                )
              ],
            ),
            Wrap(
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.end,
              spacing: 10,
              runSpacing: 10,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: Text('${weather.maxTemp.round().toString()}°C',
                      style:
                      new TextStyle(color: Colors.white, fontSize: 16.0)),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  child: Text('${weather.minTemp.round().toString()}°C',
                      style:
                      new TextStyle(color: Colors.white70, fontSize: 16.0)),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}