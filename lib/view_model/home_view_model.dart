import 'dart:convert';
import 'dart:developer';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:wac_test_001/core/helpers/snackBar.dart';
import 'package:wac_test_001/main.dart';
import 'package:wac_test_001/model/apis/apis.dart';
import 'package:wac_test_001/model/response/home_model.dart';
import 'package:wac_test_001/model/services/api_service.dart';
import 'package:wac_test_001/model/services/shared_pref_service.dart';
import 'package:wac_test_001/model/services/sqflite.dart';
import 'package:wac_test_001/view/screens/home/tabs/account_tab.dart';
import 'package:wac_test_001/view/screens/home/tabs/cart_tab.dart';
import 'package:wac_test_001/view/screens/home/tabs/category_tab.dart';
import 'package:wac_test_001/view/screens/home/tabs/home_tab.dart';
import 'package:wac_test_001/view/screens/home/tabs/offers_tab.dart';

class HomeViewModel extends ChangeNotifier {
  int _currentPage = 0;
  int _currentSlider = 0;

  String? singleBannerUrl;

  List<HomeModel> _homeModelList = [];
  List<Content> _popularProductsList = [];
  List<Content> _featuredProductsList = [];
  List<Content> _bannerList = [];
  List<Content> _categoriesList = [];

  List<Map<String, dynamic>> bannerLocalData = [];
  List<Map<String, dynamic>> popularLocalData = [];

  List<Map<String, dynamic>> categoryLocalData = [];
  List<Map<String, dynamic>> featuredLocalData = [];

  CarouselController carouselController = CarouselController();
  SharedPrefrenceService prefrenceService = SharedPrefrenceService();

  int get currentPage => _currentPage;
  int get currentSlider => _currentSlider;
  List<HomeModel> get homeModelList => _homeModelList;
  List<Content> get popularProductsList => _popularProductsList;
  List<Content> get featuredProductsList => _featuredProductsList;
  List<Content> get bannerList => _bannerList;
  List<Content> get categoriesList => _categoriesList;

  List<Widget> pages = const [
    HomeTab(),
    CategoryTab(),
    CartTab(),
    OfferTab(),
    AccountTab()
  ];

  //
  onChangePage(value) {
    _currentPage = value;
    notifyListeners();
  }

  onChangeSlider(value) {
    _currentSlider = value;
    notifyListeners();
  }

  // boottom bar icon session

  List<BottomNavigationBarItem> bottomNavBarItemList = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.category), label: "Category"),
    BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "Cart"),
    BottomNavigationBarItem(icon: Icon(Icons.discount), label: "Offers"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account")
  ];

  // api calls
  bool isLoading = false;
  Future<void> onFetchHomeAPI() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await ApiService.apiMethodSetup(
          method: apiMethod.get, url: Apis.baseUrl);
      if (response != null) {
        print(response.data);
        _homeModelList = homeModelFromJson(jsonEncode(response.data));

        for (var i in _homeModelList) {
          if (i.type == "products") {
            switch (i.title) {
              case "Best Sellers":
                _featuredProductsList = i.contents ?? [];
                saveTolocalDB(_featuredProductsList, "featured");

                break;
              case "Most Popular":
                _popularProductsList = i.contents ?? [];
                saveTolocalDB(_popularProductsList, "popular");
                break;
            }
          } else if (i.type == "banner_slider") {
            _bannerList = i.contents ?? [];
            saveTolocalDB(_bannerList, "banner");
          } else if (i.type == "catagories") {
            _categoriesList = i.contents ?? [];
            saveTolocalDB(_categoriesList, "category");
          } else if (i.type == "banner_single") {
            singleBannerUrl = i.imageUrl ?? '';
            prefrenceService.saveSingleBanner(singleBannerUrl ?? '');
          } else {}
        }

        log("popular products : ${_popularProductsList.length}");
        log("featired products : ${_featuredProductsList.length}");
        log("categories : ${_categoriesList.length}");
        log("banner : ${_bannerList.length}");
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      showSnackBar(navigatorKey.currentContext!, "Something went wrong");
    }
  }

  //! saving & fetching local data

  saveTolocalDB(list, tableName) {
    list.map((e) async {
      Map<String, dynamic> item = {
        "title": e.title,
        "imageUrl": e.imageUrl,
        "productName": e.productImage,
        "productImage": e.productImage,
        "productRating": e.productRating ?? 0,
        "actualPrice": e.actualPrice,
        "offerPrice": e.offerPrice,
        "discount": e.discount
      };
      await DatabaseHelper.instance.insertData(tableName, item);
    }).toList();
  }

  fetchLocalData() async {
    bannerLocalData = await DatabaseHelper.instance.fetchData("banner");
    popularLocalData = await DatabaseHelper.instance.fetchData("popular");
    categoryLocalData = await DatabaseHelper.instance.fetchData("category");
    featuredLocalData = await DatabaseHelper.instance.fetchData("featured");
    singleBannerUrl = await prefrenceService.getStringSingleBanner();

    _bannerList = bannerLocalData.map((e) => Content.fromJson(e)).toList();
    _popularProductsList =
        popularLocalData.map((e) => Content.fromJson(e)).toList();
    _categoriesList =
        categoryLocalData.map((e) => Content.fromJson(e)).toList();
    _featuredProductsList =
        featuredLocalData.map((e) => Content.fromJson(e)).toList();

    print(
        "bannerLocalData : $bannerLocalData ${bannerLocalData.length}  ${_bannerList.length}");
    print("popularLocalData : ${popularLocalData.length}");
    print("categoryLocalData : ${categoryLocalData.length}");
    print("featuredLocalData : ${featuredLocalData.length}");
    notifyListeners();
  }
}
