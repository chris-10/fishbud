library my_prj.globals;
import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';

bool isErrorLogin = false;
String _authHint = '';

void set_auth_err(String a){
  //RegExp exp = new RegExp(r"\((\w+)\)");
  //_authHint=exp.stringMatch(a);
  _authHint = a;
}
String get_auth_err(){
  return _authHint;
}
void set_err_bool(bool val){
  isErrorLogin=val;
}
bool get_err_bool(){
  return isErrorLogin;
}


////Chart Stuff

List<List<int>> sensorData = [
[10.0, 20.0,  5.0,  30.0,  5.0,  20.0, ],
[30.0, 60.0, 16.0, 100.0, 12.0, 120.0, ],
[25.0, 40.0, 20.0,  80.0, 12.0,  90.0, ],
[12.0, 30.0, 18.0,  40.0, 10.0,  30.0, ],
[12.0, 30.0, 18.0,  40.0, 10.0,  30.0, ],
];