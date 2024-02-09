import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motion_tab_bar/MotionBadgeWidget.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:provider/provider.dart';
import 'package:wac_test_001/model/services/sqflite.dart';
import 'package:wac_test_001/view_model/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseHelper.instance.database;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
   final homePro =    Provider.of<HomeViewModel>(context, listen: false);
   homePro.onFetchHomeAPI();
   homePro.fetchLocalData();
    });

    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 5,
      vsync: this,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _motionTabBarController!.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    final homePro = context.watch<HomeViewModel>();
    return Scaffold(
      body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _motionTabBarController,
          children: homePro.pages),

      // homePro.pages[homePro.currentPage],
      bottomNavigationBar: MotionTabBar(
        controller:
            _motionTabBarController, // ADD THIS if you need to change your tab programmatically
        initialSelectedTab: "Home",
        labels: const ["Home", "Category", "Cart", "Offers", "Account"],
        icons: const [
          Icons.home,
          FontAwesomeIcons.gauge,
          Icons.shopping_cart,
          FontAwesomeIcons.percent,
          Icons.person
        ],

        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: const Color(0xff555454),
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: const Color(0xff92C848),
        tabIconSelectedColor: Colors.white,
        tabBarColor: const Color(0xffDCDCDC),
        onTabItemSelected: (int value) {
          setState(() {
            // _tabController!.index = value;
            _motionTabBarController!.index = value;
          });
        },
      ),

      //  BottomNavigationBar(
      //   backgroundColor:const Color(0xffDCDCDC),
      //   selectedItemColor: Colors.red,
      //   unselectedItemColor: Colors.black,
      //   items: homePro.bottomNavBarItemList,
      //   onTap: homePro.onChangePage,
      // ),
    );
  }
}
