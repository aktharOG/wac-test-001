import 'package:flutter/material.dart';

push(BuildContext context, page) {
  Navigator.push(
    context,
     createRoute(page)
     
  );
}




pushAndReplace(BuildContext context, page) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => page,
    ),
  );
}


pushAndRemoveUntil(BuildContext context, page) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (_) => page,
    ),
    (_) => false,
  );
}

pop(BuildContext context){
  Navigator.pop(context);
}


Route createRoute( route) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => route  ,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // const begin = Offset(0.0, 1.0);
      // const end = Offset.zero;
      // const curve = Curves.ease;

      // var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return FadeTransition(
        opacity: animation,
      //  position: animation.drive(tween),
        child: child,
      );
    },
  );
}

