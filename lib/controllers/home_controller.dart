import 'dart:convert';
import 'dart:developer';

import 'package:dating/model/banner_model.dart';
import 'package:dating/rest/api_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchDemoBanners();
  }

  Future<void> saveDataList(List<BannerModel> dataList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonDataList =
        dataList.map((data) => json.encode(data.toJson())).toList();
    await prefs.setStringList('dataList', jsonDataList);
  }

// Save the updated bannerLocallList in SharedPreferences
  void saveBannerListToSharedPreferences(List<BannerModel> bannerList) {
    List<BannerModel> dataList = bannerList
        .map((banner) => BannerModel(
              name: banner.name,
              image: banner.image,
              createdDate: banner.createdDate,
              id: banner.id,
              v: banner.v,
            ))
        .toList();

    saveDataList(dataList);
  }

  Future<List<BannerModel>> retrieveDataList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonDataList = prefs.getStringList('dataList');
    print(jsonDataList);

    bannerLocallList = jsonDataList!
        .map((jsonData) => BannerModel.fromJson(json.decode(jsonData)))
        .toList();

    print(bannerLocallList);
    update();

    return bannerLocallList;
  }

  bool isLoading = false;
  List<dynamic> bannerList = [];
  List<BannerModel> bannerLocallList = <BannerModel>[];
  RxInt swipeCount = 0.obs;
  Future<void> fetchDemoBanners() async {
    isLoading = true;
    var result = await ApiService.getDemoBanners();
    if (true) {
      bannerList = result.body!['result'];
    }
    isLoading = false;
    update();

    log(jsonEncode(bannerList));
  }
}
