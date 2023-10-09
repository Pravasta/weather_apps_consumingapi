import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/data_detail_models.dart';

class DataDetailService {
  static Future<List<DataDetail>> fetchDataApi(String id) async {
    final url = 'https://ibnux.github.io/BMKG-importer/cuaca/$id.json';

    List<DataDetail> dataWeather = [];

    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      return [];
    }

    final data = json.decode(response.body) as List;

    for (var item in data) {
      dataWeather.add(
        DataDetail(
          jamCuaca: DateTime.parse(item['jamCuaca']),
          kodeCuaca: item['kodeCuaca'],
          cuaca: item['cuaca'],
          humidity: item['humidity'],
          tempC: item['tempC'],
          tempF: item['tempF'],
        ),
      );
    }

    return dataWeather;
  }
}
