import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/category_data_model.dart';
import '../models/event_data_model.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getCategoryList();
    super.onInit();
  }

  @override
  void dispose() {
    eventScrollController.dispose();
    super.dispose();
  }

  ScrollController eventScrollController = ScrollController();
  GetConnect getConnect = GetConnect();
  RxBool isLoadingEvent = false.obs;
  RxBool isCategoryShowInList = true.obs;
  RxBool isEventShowInList = true.obs;
  RxBool isFavoriteEvent = false.obs;
  String selectedCategory = "";
  Map<String, EventData> eventList = <String, EventData>{};
  List<CategoryData> categoryList = <CategoryData>[];

  Future<void> getCategoryList() async {
    try {
      isLoadingEvent.value = true;
      String baseUrl = "https://allevents.s3.amazonaws.com/tests/categories.json";
      final Response response = await getConnect.get(baseUrl);
      if (response.statusCode == 200) {
        categoryList = categoryDataFromJson(response.bodyString!);
        if (categoryList.isNotEmpty) {
          selectedCategory = categoryList.first.category ?? "";
          for (CategoryData categoryData in categoryList) {
            if (categoryData.category != null && categoryData.data != null) {
              String dataUrl = categoryData.data ?? "";
              final Response response = await getConnect.get(dataUrl);
              if (response.statusCode == 200) {
                EventData eventData = eventDataFromJson(response.bodyString!);
                eventList[categoryData.category ?? ""] = eventData;
              }
            }
          }
        }
        update(["home"]);
      } else {
        Get.rawSnackbar(message: "Something went wrong");
      }
    } on Exception catch (error) {
      log(error.toString());
    } finally {
      isLoadingEvent.value = false;
    }
  }
  
  void shareEventDetails(String text){
    Share.share(text);
  }


}
