import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui' show lerpDouble;
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import '../../Components/auth.dart';
import 'package:flutter/services.dart';
import 'package:dribbbledanimation/Components/card_data.dart';
import  'card_view.dart';
import 'card_flipper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, this.auth, this.onSignOut}) : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignOut;

  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  var animateStatus = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  double scrollPercent = 0.0;

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.3;
    Size screenSize = MediaQuery.of(context).size;

    void _signOut() async {
      try {
        await widget.auth.signOut();
        widget.onSignOut();
      } catch (e) {
        print(e);
      }
    }

    return (new WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text(
            "FishBud Portal",
            style: new TextStyle(
              fontSize: Theme.of(context).platform == TargetPlatform.iOS ? 17.0 : 20.0,
            ),
          ),
          elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
          actions: <Widget>[
            new FlatButton(
                onPressed: _signOut,
                child: new Text('Logout', style: new TextStyle(fontSize: 20.0, color: Colors.white))
            )
          ],
        ),
        backgroundColor: Colors.black38,
        body: new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new ExactAssetImage('assets/images/home_bg.gif'),
              fit: BoxFit.cover,
            ),
          ),
          child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Spacer for status bar
            new Container(
              width: double.infinity,
              height: 20.0,
            ),

            // Cards
            new Expanded(
              child: new CardFlipper(
                  cards: demoCards,
                  onScroll: (double scrollPercent) {
                    setState(() => this.scrollPercent = scrollPercent);
                  }),
            ),

            // Scroll Indicator
            new BottomBar(
              cardCount: demoCards.length,
              scrollPercent: scrollPercent,
            ),
          ],
        ),
        ),
      ),
    ));
  }
}
