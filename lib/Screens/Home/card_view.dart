import 'package:flutter/material.dart';
import 'package:dribbbledanimation/Components/card_data.dart';
import 'dart:math';
import 'dart:ui' show lerpDouble;
import 'package:dribbbledanimation/Components/portal_chart.dart';
import '../../globals.dart' as globals;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:percent_indicator/percent_indicator.dart';

class HomeCard extends StatelessWidget {
  final CardViewModel viewModel;
  final double parallaxPercent; // [0.0, 1.0] (0.0 for all the way right, 1.0 for all the way left)

  HomeCard({
    this.viewModel,
    this.parallaxPercent = 0.0,
  });

  Widget body_clip_rect() {
    return new ClipRRect(
      borderRadius: new BorderRadius.circular(10.0),
      child: new Container(
        child: new FractionalTranslation(
          translation: new Offset(parallaxPercent * 2.0, 0.0),
          child: new OverflowBox(
            maxWidth: double.infinity,
            child: new Image.asset(
              viewModel.backdropAssetPath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget body_stack() {
        // Content
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0, bottom: 30.0),
              child: new Text(
                '${viewModel.tankName}'.toUpperCase(),
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 35.0,
                  fontFamily: 'petita',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            new Expanded(child: new Container(
            )),

            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Icon(
                  Icons.perm_device_information,
                  color: Colors.white,
                  size: 50.0,
                ),
                new Text(
                  '${viewModel.tempInDegrees}',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    fontFamily: 'petita',
                    letterSpacing: 1.0,
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                  child: new Text(
                    '°C',
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 45.0,
                      fontFamily: 'petita',
                    ),
                  ),
                ),
              ],
            ),

            new Expanded(child: new Container(
            )),

            new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: new Icon(
                      Icons.timelapse,
                      color: Colors.white,
                      size: 30.0,
                    ),),
                new Text(
                  '${viewModel.pHval}',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontFamily: 'petita',
                    letterSpacing: 1.0,
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 15.0, right: 10.0),
                  child: new Text(
                    'pH',
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontFamily: 'petita',
                    ),
                  ),
                ),
    new Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: new Icon(
                      Icons.adjust,
                      color: Colors.white,
                      size: 30.0,
                    ),),
                    new Text(
                      '${viewModel.turbidity}',
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontFamily: 'petita',
                        letterSpacing: 1.0,
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(left: 5.0, top: 15.0),
                      child: new Text(
                        'NTU',
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontFamily: 'petita',
                        ),
                      ),
                    ),
              ],
            ),

            new Expanded(child: new Container()),

            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              new Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child:
    new Icon(
                  Icons.select_all,
                  color: Colors.white,
                  size: 30.0,
                ),),
                new Text(
                  '${viewModel.salinity}',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontFamily: 'petita',
                    letterSpacing: 1.0,
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 15.0, right: 0.0),
                  child: new Text(
                    'ppm',
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontFamily: 'petita',
                    ),
                  ),
                ),
                    new Padding(
                    padding: const EdgeInsets.only(top: 10.0),
    child:
    new Icon(
                  Icons.assessment,
                  color: Colors.white,
                  size: 30.0,
                ),),
                new Text(
                  '${viewModel.DOval}',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontFamily: 'petita',
                    letterSpacing: 1.0,
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 15.0),
                  child: new Text(
                    'mg/L',
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontFamily: 'petita',
                    ),
                  ),
                ),
              ],
            ),

            new Expanded(child: new Container()),

            new Padding(
              padding: const EdgeInsets.only(top: 50.0, bottom: 50.0, left: 25.0, right: 25.0),
              child: new Container(
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(40.0),
                  border: new Border.all(
                    color: Colors.white,
                    width: 1.5,
                  ),
                  color: Colors.black.withOpacity(0.3),
                ),
                child: new Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  child: new LinearPercentIndicator(
                    width: 170.0,
                    animation: true,
                    animationDuration: 1000,
                    lineHeight: 20.0,
                    leading: new Text("Quality"),
                    percent: viewModel.waterQuality,
                    center: Text('${viewModel.waterQuality*100} %'),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: Colors.cyan[800],
                  ),
                ),
              ),
            ),
          ],
        );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        fit: StackFit.expand,
        children: <Widget>[
          body_clip_rect(),
          body_stack(),
              /*new charts.LineChart(globals.seriesList, animate: true, behaviors: [
                new charts.PanAndZoomBehavior(),
              ]),*/
    ],
    );

  }
}

class BottomBar extends StatelessWidget {
  final int cardCount;
  final double scrollPercent;

  BottomBar({
    this.cardCount,
    this.scrollPercent,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      child: new Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Center(
                child: new Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ),
            ),
            new Expanded(
              child: new Center(
                child: new Container(
                  width: double.infinity,
                  height: 5.0,
                  child: new ScrollIndicator(
                    cardCount: cardCount,
                    scrollPercent: scrollPercent,
                  ),
                ),
              ),
            ),
            new Expanded(
              child: new Center(
                child: new Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScrollIndicator extends StatelessWidget {
  final int cardCount;
  final double scrollPercent;

  ScrollIndicator({
    this.cardCount,
    this.scrollPercent,
  });

  @override
  Widget build(BuildContext context) {
    return new CustomPaint(
      painter: new ScrollIndicatorPainter(
        cardCount: cardCount,
        scrollPercent: scrollPercent,
      ),
      child: new Container(),
    );
  }
}

class ScrollIndicatorPainter extends CustomPainter {
  final int cardCount;
  final double scrollPercent;
  final Paint trackPaint;
  final Paint thumbPaint;

  ScrollIndicatorPainter({
    this.cardCount,
    this.scrollPercent,
  })  : trackPaint = new Paint()
    ..color = const Color(0xFF444444)
    ..style = PaintingStyle.fill,
        thumbPaint = new Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    // Draw track
    canvas.drawRRect(
      new RRect.fromRectAndCorners(
        new Rect.fromLTWH(
          0.0,
          0.0,
          size.width,
          size.height,
        ),
        topLeft: new Radius.circular(3.0),
        topRight: new Radius.circular(3.0),
        bottomLeft: new Radius.circular(3.0),
        bottomRight: new Radius.circular(3.0),
      ),
      trackPaint,
    );

    // Draw thumb
    final thumbWidth = size.width / cardCount;
    final thumbLeft = scrollPercent * size.width;

    Path thumbPath = new Path();
    thumbPath.addRRect(
      new RRect.fromRectAndCorners(
        new Rect.fromLTWH(
          thumbLeft,
          0.0,
          thumbWidth,
          size.height,
        ),
        topLeft: new Radius.circular(3.0),
        topRight: new Radius.circular(3.0),
        bottomLeft: new Radius.circular(3.0),
        bottomRight: new Radius.circular(3.0),
      ),
    );

    // Thumb shape
    canvas.drawPath(
      thumbPath,
      thumbPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}