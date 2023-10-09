import 'package:flutter/material.dart';
import 'package:weather_app/common/utils/app_color/app_color.dart';

class ModalBottomSheet {
  static Future<dynamic> modalBottomSheet(BuildContext context, Widget data) {
    return showModalBottomSheet(
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 2 / 3,
          decoration: const BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: SingleChildScrollView(child: data),
        );
      },
    );
  }
}
