import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrenceService {

  static late final SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  saveSingleBanner(String name) {
    prefs.setString("single-banner", name);
  
  }

  getStringSingleBanner() {
    var name = prefs.getString("single-banner");
    return name;
  }

  
}