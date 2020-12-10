import 'package:flutter/material.dart';

// class RouteTransition<T> extends MaterialPageRoute<T> {
//   RouteTransition({WidgetBuilder builder, RouteSettings settings})
//       : super(
//           settings: settings,
//           builder: builder,
//         );

//   @override
//   Widget buildTransitions(
//     BuildContext context,
//     Animation<double> animation,
//     Animation<double> secondaryAnimation,
//     Widget child,
//   ) {
//     return SlideTransition(
//       position: Tween<Offset>(begin: Offset(1, 0), end: Offset.zero).animate(
//         CurvedAnimation(
//           curve: Curves.easeIn,
//           parent: animation,
//         ),
//       ),
//       child: child,
//     );
//   }
// }

class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return SlideTransition(
      position: Tween<Offset>(begin: Offset(1, 0), end: Offset.zero).animate(
        CurvedAnimation(
          curve: Curves.easeIn,
          parent: animation,
        ),
      ),
      child: child,
    );
  }
}
