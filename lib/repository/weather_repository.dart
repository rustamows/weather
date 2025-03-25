import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/const/const.dart';
import 'package:weather/model/forcast_model.dart';
import 'package:weather/model/weather_models.dart';


class WeatherRepository {
  Future<WeatherModel?> getWeatherModel(String cityName) async {
    var res = await http.get(Uri.parse(
        '${Const.BaseUrl}/weather?q=$cityName&appid=${Const.ApiKey}&units=metric'));
    if (res.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(res.body));
    } else {
      return null;
    }
  }
  Future<ForcastModel?> getForcastModel(String cityName) async {
    var res = await http.get(Uri.parse(
        '${Const.BaseUrl}/forecast?q=$cityName&appid=${Const.ApiKey}&units=metric'));
        print('--r:${res.body}');
        print('--r:${Const.BaseUrl}/forcast?q=$cityName&appid=${Const.ApiKey}&units=metric');
    if (res.statusCode == 200) {
      return ForcastModel.fromJson(jsonDecode(res.body));
    } else {
      return null;
    }
  }
}
