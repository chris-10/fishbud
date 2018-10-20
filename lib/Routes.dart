import 'package:flutter/material.dart';
import 'package:dribbbledanimation/Screens/Login/index.dart';
import 'package:dribbbledanimation/Screens/Home/index.dart';
import 'package:dribbbledanimation/Screens/Home/tank_home.dart';
import 'package:dribbbledanimation/Components/auth.dart';

class Routes {
  Routes() {
    runApp(new MaterialApp(
      title: "Fish Bud",
      theme:
      ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.white70,
        primaryColor: Colors.cyan[900],
        backgroundColor: Colors.white70,
        accentColor: Colors.cyan[800],
      ),
      debugShowCheckedModeBanner: false,
      home: new LoginScreen(auth: new Auth()),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/login':
            return new MyCustomRoute(
              builder: (_) => new LoginScreen(auth: new Auth()),
              settings: settings,
            );

          case '/home':
            return new MyCustomRoute(
              builder: (_) => new HomeScreen(),
              settings: settings,
            );

          case '/tank_home':
            return new MyCustomRoute(
              builder: (_) => new TankHome(),
              settings: settings,
            );
        }
      },
    ));
  }
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    return new FadeTransition(opacity: animation, child: child);
  }
}
