import 'dart:convert';
import 'dart:developer';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:wac_test_001/core/helpers/snackBar.dart';
import 'package:wac_test_001/main.dart';
import 'package:wac_test_001/model/apis/apis.dart';
import 'package:wac_test_001/model/response/home_model.dart';
import 'package:wac_test_001/model/services/api_service.dart';
import 'package:wac_test_001/view/screens/home/tabs/account_tab.dart';
import 'package:wac_test_001/view/screens/home/tabs/cart_tab.dart';
import 'package:wac_test_001/view/screens/home/tabs/category_tab.dart';
import 'package:wac_test_001/view/screens/home/tabs/home_tab.dart';
import 'package:wac_test_001/view/screens/home/tabs/offers_tab.dart';

class HomeViewModel extends ChangeNotifier {
  int _currentPage = 0;
  int _currentSlider = 0;

  String singleBannerUrl = "";

  List<HomeModel> _homeModelList = [];
  List<Content> _popularProductsList = [];
  List<Content> _featuredProductsList = [];
  List<Content> _bannerList = [];
  List<Content> _categoriesList = [];



  CarouselController carouselController = CarouselController();

  int get currentPage => _currentPage;
  int get currentSlider => _currentSlider;
  List<HomeModel> get homeModelList => _homeModelList;
  List<Content> get popularProductsList => _popularProductsList;
  List<Content> get featuredProductsList => _featuredProductsList;
  List<Content> get bannerList => _bannerList;
  List<Content> get categoriesList => _categoriesList;

  List pages = const [
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
                break;
              case "Most Popular":
                _popularProductsList = i.contents ?? [];
                break;
            }
          }else if(i.type =="banner_slider"){
            _bannerList = i.contents??[];
          }else if (i.type == "catagories"){
            _categoriesList = i.contents??[];
          }else if (i.type == "banner_single"){
            singleBannerUrl = i.imageUrl??'';
          }
          
          else{

          }
        }

        log("popular products : ${_popularProductsList.length}");
        log("featired products : ${_featuredProductsList.length}");
                log("categories : ${_categoriesList.length}");
        log("banner : ${_bannerList.length}");

      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      showSnackBar(navigatorKey.currentContext!, "Something went wrong");
    }
  }
}
