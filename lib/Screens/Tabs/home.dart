import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new HomePageBody(),
    );
  }
}

class HomePageBody extends StatefulWidget {
  @override
  _HomePageBodyState createState() => new _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {

  final background = Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/home_bg.jpg'),
        fit: BoxFit.cover,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
        background,
        /*new Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[*/
            new Swiper(
              itemBuilder: (BuildContext context, int index) {
                return new Image.network(
                  "http://via.placeholder.com/288x188",
                  fit: BoxFit.fill,
                );
              },
              scrollDirection: Axis.vertical,
              pagination: new SwiperPagination(),
              itemCount: 10,
              itemWidth: 300.0,
              itemHeight: 400.0,
              layout: SwiperLayout.STACK,
            ),])
            /*])]),
    );*/
    );
  }
}