import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wac_test_001/view_model/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
       Provider.of<HomeViewModel>(context,listen: false).onFetchHomeAPI();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homePro = context.watch<HomeViewModel>();
    return Scaffold(
      body: homePro.pages[homePro.currentPage],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:const Color(0xffDCDCDC),
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        items: homePro.bottomNavBarItemList,
        onTap: homePro.onChangePage,
      ),
    );
  }
}
