import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wac_test_001/model/services/shared_pref_service.dart';
import 'package:wac_test_001/view/screens/home/home_screen.dart';
import 'package:wac_test_001/view_model/home_view_model.dart';


GlobalKey<NavigatorState> navigatorKey = GlobalKey();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
 SharedPrefrenceService().init(); 
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeViewModel(),)
      ],
      child:  ScreenUtilInit(
             designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: "Poppins"),
          navigatorKey: navigatorKey,
          home: const HomeScreen()
        ),
      ),
    );
  }
}
