// To parse this JSON data, do
//
//     final dataDetail = dataDetailFromJson(jsonString);

import 'dart:convert';

List<DataDetail> dataDetailFromJson(String str) =>
    List<DataDetail>.from(json.decode(str).map((x) => DataDetail.fromJson(x)));

String dataDetailToJson(List<DataDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataDetail {
  DateTime jamCuaca;
  String kodeCuaca;
  String cuaca;
  String humidity;
  String tempC;
  String tempF;

  DataDetail({
    required this.jamCuaca,
    required this.kodeCuaca,
    required this.cuaca,
    required this.humidity,
    required this.tempC,
    required this.tempF,
  });

  factory DataDetail.fromJson(Map<String, dynamic> json) => DataDetail(
        jamCuaca: DateTime.parse(json["jamCuaca"]),
        kodeCuaca: json["kodeCuaca"],
        cuaca: json["cuaca"],
        humidity: json["humidity"],
        tempC: json["tempC"],
        tempF: json["tempF"],
      );

  Map<String, dynamic> toJson() => {
        "jamCuaca": jamCuaca.toIso8601String(),
        "kodeCuaca": kodeCuaca,
        "cuaca": cuaca,
        "humidity": humidity,
        "tempC": tempC,
        "tempF": tempF,
      };
}
