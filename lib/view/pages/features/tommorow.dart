import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/common/utils/app_text/app_text.dart';
import 'package:weather_app/models/data_detail_models.dart';
import 'package:weather_app/service/data_detail_service.dart';

import '../../widgets/data_widget.dart';

class Tommorow extends StatelessWidget {
  const Tommorow({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DataDetail>>(
      future: DataDetailService.fetchDataApi(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: Text(
              'Error',
              style: AppText.text18,
            ),
          );
        }

        DateTime currentDate = DateTime.now();
        DateTime tommorowDate = currentDate.add(const Duration(days: 1));

        String tommorowFormated = DateFormat('yyyy-MM-dd').format(tommorowDate);

        var dateToday = snapshot.data!
            .where(
              (element) => element.jamCuaca
                  .toIso8601String()
                  .startsWith(tommorowFormated),
            )
            .toList();

        return SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: dateToday.map(
              (e) {
                return DataWidget(
                  time: e.jamCuaca,
                  code: e.kodeCuaca,
                  temp: e.tempC,
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }
}
