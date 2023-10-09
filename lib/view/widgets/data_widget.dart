import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/common/utils/app_color/app_color.dart';
import 'package:weather_app/common/utils/app_text/app_text.dart';

class DataWidget extends StatelessWidget {
  const DataWidget({
    super.key,
    required this.time,
    required this.code,
    required this.temp,
  });

  final DateTime time;
  final String code;
  final String temp;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat('HH:mm').format(time),
            style: AppText.text20.copyWith(
              color: AppColor.blackColor,
            ),
          ),
          Image.network(
            'https://ibnux.github.io/BMKG-importer/icon/${code}.png',
            width: 40,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                temp,
                style: AppText.text20.copyWith(
                  color: AppColor.blackColor,
                ),
              ),
              Text(
                String.fromCharCode(0x00B0),
                style: AppText.text16.copyWith(
                  color: AppColor.blackColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
