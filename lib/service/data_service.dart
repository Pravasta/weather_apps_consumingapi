import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/data_models.dart';

class DataService {
  static Future<List<Data>> fetchDataApi() async {
    const url = 'https://ibnux.github.io/BMKG-importer/cuaca/wilayah.json';

    List<Data> dataWeather = [];

    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      return [];
    }

    final data = json.decode(response.body);

    for (var item in data) {
      dataWeather.add(
        Data(
          id: item['id'],
          propinsi: item['propinsi'],
          kota: item['kota'],
          kecamatan: item['kecamatan'],
          lat: item['lat'],
          lon: item['lon'],
        ),
      );
    }

    return dataWeather;
  }
}
