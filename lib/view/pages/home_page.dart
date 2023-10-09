import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/common/preferences/preferences_helper.dart';
import 'package:weather_app/common/utils/app_color/app_color.dart';
import 'package:weather_app/common/utils/app_text/app_text.dart';
import 'package:weather_app/common/utils/modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:weather_app/models/data_detail_models.dart';
import 'package:weather_app/service/data_detail_service.dart';
import 'package:weather_app/view/pages/features/today.dart';
import 'package:weather_app/view/pages/features/tommorow.dart';

import '../../models/data_models.dart';
import '../../service/data_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _selectProvince;
  String? _selectCity;
  String? _id;

  final prefs =
      PreferedHelper(sharedPreferences: SharedPreferences.getInstance());

  getId() async {
    final id = await prefs.getPrefs('id');
    final selectProvince = await prefs.getPrefs('province');
    final selectCity = await prefs.getPrefs('city');
    if (_id == null && _selectCity == null && _selectProvince == null) {
      _id = id;
      _selectProvince = selectProvince;
      _selectCity = selectCity;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getId();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _header(context),
                      if (_id != null) _middle(),
                    ],
                  ),
                ),
                _bottom(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_selectProvince != null)
              Text(
                '$_selectProvince',
                style: AppText.text18.copyWith(
                  color: AppColor.whiteColor,
                ),
              ),
            GestureDetector(
              onTap: () {
                ModalBottomSheet.modalBottomSheet(
                  context,
                  FutureBuilder<List<Data>>(
                    future: DataService.fetchDataApi(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColor.whiteColor,
                          ),
                        );
                      }

                      if (!snapshot.hasData) {
                        return Text(
                          'Data not Found',
                          style: AppText.text18,
                        );
                      }

                      return Column(
                        children: snapshot.data!.map((e) {
                          return ListTile(
                            onTap: () async {
                              final navigator = Navigator.of(context);

                              _selectProvince = e.propinsi.toString();
                              _selectCity = e.kota.toString();
                              _id = e.id.toString();

                              await prefs.setPrefs('id', _id.toString());
                              await prefs.setPrefs(
                                  'province', _selectProvince.toString());
                              await prefs.setPrefs(
                                  'city', _selectCity.toString());

                              setState(() {});
                              navigator.pop();
                            },
                            title: Text(
                              '${e.propinsi} - ${e.kota}',
                              style: AppText.text18.copyWith(
                                color: AppColor.whiteColor,
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                );
              },
              child: const Icon(
                Icons.arrow_drop_down_outlined,
                color: AppColor.whiteColor,
                size: 30,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (_selectCity != null)
          Text(
            '$_selectCity',
            style: AppText.text20.copyWith(
              color: AppColor.whiteColor,
              fontWeight: AppText.fontWeight['500'],
            ),
          ),
      ],
    );
  }

  Widget _middle() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        width: double.infinity,
        child: FutureBuilder<List<DataDetail>>(
          future: DataDetailService.fetchDataApi('$_id'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColor.whiteColor,
                ),
              );
            }

            if (!snapshot.hasData) {
              return const Center(
                child: Text('Tidak ada Data'),
              );
            }

            final data = snapshot.data?[0];

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data!.tempC,
                      style: AppText.text48.copyWith(
                        color: AppColor.whiteColor,
                        fontSize: 100,
                      ),
                    ),
                    Text(
                      String.fromCharCode(0x00B0),
                      style: AppText.text48.copyWith(
                        color: AppColor.whiteColor,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  DateFormat("EEEE, d MMMM HH:mm").format(DateTime.now()),
                  style: AppText.text16.copyWith(
                    color: AppColor.whiteColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  data.cuaca,
                  style: AppText.text18.copyWith(
                    color: AppColor.whiteColor,
                  ),
                ),
                const SizedBox(height: 30),
                Image.network(
                  'https://ibnux.github.io/BMKG-importer/icon/${data.kodeCuaca}.png',
                  width: 120,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        ));
  }

  Widget _bottom(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 1 / 3,
      decoration: const BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: TabBar(
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              indicatorWeight: 2,
              labelColor: AppColor.blackColor,
              labelStyle: AppText.text14,
              unselectedLabelColor: AppColor.greyColor,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: AppColor.blackColor,
              tabs: const [
                Tab(
                  child: Text(
                    'Hari ini',
                  ),
                ),
                Tab(
                  child: Text(
                    'Besok',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              child: TabBarView(
                children: [
                  Today(id: _id.toString()),
                  Tommorow(id: _id.toString()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
