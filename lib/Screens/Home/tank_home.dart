import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import '../Tabs/home.dart' as _firstTab;
import '../Tabs/dashboard.dart' as _secondTab;
import '../Tabs/live_graph.dart' as _thirdTab;
import '../../Components/about.dart' as _aboutPage;
import '../../Components/support.dart' as _supportPage;

class TankHome extends StatefulWidget {

  TankHome({Key key, this.title}) : super(key: key);

  final String title;
  @override
  TankScreenState createState() {
    return TankScreenState();
  }
}

class TankScreenState extends State<TankHome> with SingleTickerProviderStateMixin{

  PageController _tabController;

  var _title_app = null;
  int _tab = 0;
  bool _loadingInProgress;
  Animation<double> _angleAnimation;

  Animation<double> _scaleAnimation;

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _loadingInProgress = true;

    _controller = new AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    _angleAnimation = new Tween(begin: 0.0, end: 360.0).animate(_controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    _scaleAnimation = new Tween(begin: 2.0, end: 3.0).animate(_controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });

    _angleAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_loadingInProgress) {
          _controller.reverse();
        }
      } else if (status == AnimationStatus.dismissed) {
        if (_loadingInProgress) {
          _controller.forward();
        }
      }
    });

    _controller.forward();

    _tabController = new PageController();
    this._title_app = TabItems[0].title;

    _loadData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: _buildBody(),

        //Tabs
        bottomNavigationBar: Theme.of(context).platform == TargetPlatform.iOS ?
        new CupertinoTabBar(
          activeColor: Colors.blueGrey,
          currentIndex: _tab,
          onTap: onTap,
          items: TabItems.map((TabItem) {
            return new BottomNavigationBarItem(
              title: new Text(TabItem.title),
              icon: new Icon(TabItem.icon),
            );
          }).toList(),
        ):
        new BottomNavigationBar(
          currentIndex: _tab,
          onTap: onTap,
          items: TabItems.map((TabItem) {
            return new BottomNavigationBarItem(
              title: new Text(TabItem.title),
              icon: new Icon(TabItem.icon),
            );
          }).toList(),
        ),

        //Drawer
        drawer: new Drawer(
            child: new ListView(
              children: <Widget>[
                new Container(
                  height: 120.0,
                  child: new DrawerHeader(
                    padding: new EdgeInsets.all(0.0),
                    decoration: new BoxDecoration(
                      color: new Color(0xFFECEFF1),
                    ),
                    child: Image.asset(
                      'assets/images/AMSPL.png',
                      width: 180.0,
                      height: 180.0,
                    ),
                  ),
                ),
                new ListTile(
                    leading: new Icon(Icons.chat),
                    title: new Text('Support'),
                    onTap: () {
                      Navigator.pop(context);
                      return new _aboutPage.About();
                    }
                ),
                new ListTile(
                    leading: new Icon(Icons.info),
                    title: new Text('About'),
                    onTap: () {
                      Navigator.pop(context);
                      //Navigator.of(context).pushNamed('/about');
                      return new _supportPage.Support();
                    }
                ),
                new Divider(),
                new ListTile(
                    leading: new Icon(Icons.exit_to_app),
                    title: new Text('Sign Out'),
                    onTap: () {
                      Navigator.pop(context);
                    }
                ),
              ],
            )
        )
    );
  }

  Widget _buildBody() {
    if (_loadingInProgress) {
      return new Center(
        child: _buildAnimation(),
      );
    } else {
      return new PageView(
        controller: _tabController,
        onPageChanged: onTabChanged,
        children: <Widget>[
          new _firstTab.Home(),
          new _secondTab.Dashboard(),
          new _thirdTab.LiveGraph()
        ],
      );
    }
  }

  Widget _buildAnimation() {
    double circleWidth = 10.0 * _scaleAnimation.value;
    Widget circles = new Container(
      width: circleWidth * 2.0,
      height: circleWidth * 2.0,
      child: new Column(
        children: <Widget>[
          new Row (
            children: <Widget>[
              _buildCircle(circleWidth,Colors.blue),
              _buildCircle(circleWidth,Colors.red),
            ],
          ),
          new Row (
            children: <Widget>[
              _buildCircle(circleWidth,Colors.yellow),
              _buildCircle(circleWidth,Colors.green),
            ],
          ),
        ],
      ),
    );

    double angleInDegrees = _angleAnimation.value;
    return new Transform.rotate(
      angle: angleInDegrees / 360 * 2 * math.pi,
      child: new Container(
        child: circles,
      ),
    );
  }

  Widget _buildCircle(double circleWidth, Color color) {
    return new Container(
      width: circleWidth,
      height: circleWidth,
      decoration: new BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Future _loadData() async {
    await new Future.delayed(new Duration(seconds: 1));
    _dataLoaded();
  }

  void _dataLoaded() {
    setState(() {
      _loadingInProgress = false;
    });
  }

  void onTap(int tab){
    _tabController.jumpToPage(tab);
  }

  void onTabChanged(int tab) {
    setState((){
      this._tab = tab;
    });

    switch (tab) {
      case 0:
        this._title_app = TabItems[0].title;
        break;

      case 1:
        this._title_app = TabItems[1].title;
        break;

      case 2:
        this._title_app = TabItems[2].title;
        break;
    }
  }

}

class TabItem {
  const TabItem({ this.title, this.icon });
  final String title;
  final IconData icon;
}

const List<TabItem> TabItems = const <TabItem>[
  const TabItem(title: 'Home', icon: Icons.home),
  const TabItem(title: 'Dashboard', icon: Icons.dashboard),
  const TabItem(title: 'Live Graph', icon: Icons.show_chart)
];