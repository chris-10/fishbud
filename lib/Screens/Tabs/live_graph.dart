import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_charts/flutter_charts.dart';

class LiveGraph extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new LiveGraphBody(),
    );
  }
}

class LiveGraphBody extends StatefulWidget {

  LiveGraphBody({Key key}) : super(key: key);
  @override
  _LiveGraphState createState() {
    return _LiveGraphState();
  }
}

class _LiveGraphState extends State<LiveGraphBody> {
  LineChartOptions _lineChartOptions;
  LabelLayoutStrategy _xContainerLabelLayoutStrategy;
  ChartData _chartData;

  void defineOptionsAndData() {
    _lineChartOptions = new LineChartOptions();
    _chartData = new ChartData();
    _chartData.dataRowsLegends = [
      "Temp",
      "pH",
      "Turb",
      "Sal",
      "DO"];
    _chartData.dataRows = [
      [10.0, 20.0,  5.0,  30.0,  5.0,  20.0, ],
      [30.0, 60.0, 16.0, 100.0, 12.0, 120.0, ],
      [25.0, 40.0, 20.0,  80.0, 12.0,  90.0, ],
      [12.0, 30.0, 18.0,  40.0, 10.0,  30.0, ],
      [12.0, 30.0, 18.0,  40.0, 10.0,  30.0, ],
    ];
    _chartData.xLabels =  ["-50", "-40", "-30", "-20", "-10", "Now"];
    _chartData.assignDataRowsDefaultColors();
    // Note: ChartOptions.useUserProvidedYLabels default is still used (false);
  }

  void _chartStateChanger() {
    setState(() {
      // This call to setState tells the Flutter framework that
      // something has changed in this State, which causes it to rerun
      // the build method below so that the display can reflect the
      // updated values. If we changed state without calling
      // setState(), then the build method would not be called again,
      // and so nothing would appear to happen.
      defineOptionsAndData();
    });
  }

  @override
  Widget build(BuildContext context) {
    defineOptionsAndData();
    LineChart linearChart = new LineChart(
      painter: new LineChartPainter(),
      container: new LineChartContainer(
        chartData: _chartData, // @required
        chartOptions: _lineChartOptions, // @required
        xContainerLabelLayoutStrategy:
        _xContainerLabelLayoutStrategy, // @optional
      ),
    );
    return new Scaffold(
      backgroundColor: Colors.white70,
      body:  new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        /*new Padding(
                        padding: const EdgeInsets.all(20.0)),*/
                        new Expanded(
                          child: linearChart, // verticalBarChart, lineChart
                        ),
                        // new Text('<<'), // horizontal
                        // new Text('<<<<<<'),   // tilted
                        // new Text('<<<<<<<<<<<'),   // skiped (shows 3 labels, legend present)
                        // new Text('<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'), // skiped (shows 2 labels, legend present but text vertical)
                        // new Text('<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'),// labels do overlap, legend NOT present
                        //new Text('<<<<<<<<<<<'), // labels do overlap, legend NOT present
                      ],
                    ),
                  ),
              ],),
          ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _chartStateChanger,
        tooltip: 'Update Graph',
        child: new Icon(Icons.add),
      ),
    );
  }
}