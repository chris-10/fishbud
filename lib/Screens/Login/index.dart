import 'package:flutter/material.dart';
import 'styles.dart';
import 'loginAnimation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';
import 'dart:async';
import '../../Components/SignUpLink.dart';
import '../../Components/Form.dart';
import '../../Components/SignInButton.dart';
import '../../Components/WhiteTick.dart';
import '../../Components/auth.dart';
import '../Home/index.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import '../../globals.dart' as globals;
import 'package:flushbar/flushbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key, this.auth}) : super(key: key);
  final BaseAuth auth;
  @override
  LoginScreenState createState() => new LoginScreenState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {

  String _password;
  String _email;
  static final formKey = new GlobalKey<FormState>();
  AuthStatus authStatus = AuthStatus.notSignedIn;
  AnimationController _loginButtonController;
  var animationStatus = 0;
  String _authHint = '';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Flushbar flush;
  bool _wasButtonClicked;

  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        authStatus =
        userId != null ? AuthStatus.signedIn : AuthStatus.notSignedIn;
      });
    });
    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 4000), vsync: this);
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /*bool validateAndSave() {
    //final form = formKey.currentState;
    //if (form.validate()) {
      //form.save();
      return true;
    //}
    //return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        String userId = await widget.auth.signIn(_email, _password);
        setState(() {
          _authHint = 'Signed In\n\nUser id: $userId';
        });
      }
      catch (e) {
        setState(() {
          _authHint = e.toString();
        });
        new AlertDialog(title: new Text("Sign In Error"),
          content: new Text(_authHint),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    } else {
      setState(() {
        _authHint = '';
      });
    }
  }

  void validateAndSubmit2() async {
    if (validateAndSave()) {
      try {
        String userId = await widget.auth.createUser(_email, _password);
        setState(() {
          _authHint = 'User Created\n\nUser id: $userId';
          animationStatus = 1;
          _updateAuthStatus(AuthStatus.signedIn);
        });
        new StaggerAnimation(
          buttonController: _loginButtonController.view,);
      }
      catch (e) {
        setState(() {
          _authHint = e.toString();
        });
        new AlertDialog(title: new Text("Create User Error"),
          content: new Text(_authHint),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    } else {
      setState(() {
        _authHint = '';
      });
    }
  }*/

  void _updateAuthStatus(AuthStatus status) {
    setState(() {
      authStatus = status;
    });
  }

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
      await _loginButtonController.reverse();
    } on TickerCanceled {}
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text('Are you sure?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, "/home"),
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        timeDilation = 0.4;
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        return (new WillPopScope(
            onWillPop: _onWillPop,
            child: new Scaffold(
              body: Builder(
                // Create an inner BuildContext so that the onPressed methods
                // can refer to the Scaffold with Scaffold.of().
                builder: (BuildContext context) {
                  return new Container(
                  decoration: new BoxDecoration(
                    image: backgroundImage,
                  ),
                  child: new Container(
                      decoration: new BoxDecoration(
                        /*    gradient: new LinearGradient(
                    colors: <Color>[
                      const Color.fromRGBO(162, 146, 199, 0.8),
                      const Color.fromRGBO(51, 51, 63, 0.9),
                    ],
                    stops: [0.2, 1.0],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.0, 1.0),
                  ),*/
                        color: Color(0x66608BCC),
                      ),
                      child: new ListView(
                        padding: const EdgeInsets.all(0.0),
                        children: <Widget>[
                          new Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                children: <Widget>[
                                  new Tick(image: tick),

                                  new Container(
                                    margin: new EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: new Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceEvenly,
                                      children: <Widget>[
                                        new Form(
                                            child: new Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceAround,
                                              children: <Widget>[
                                                new Container(
                                                  decoration: new BoxDecoration(
                                                    border: new Border(
                                                      bottom: new BorderSide(
                                                        width: 0.5,
                                                        color: Colors.white24,
                                                      ),
                                                    ),
                                                  ),
                                                  child: new TextFormField(
                                                    obscureText: false,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    decoration: new InputDecoration(
                                                      icon: new Icon(
                                                        Icons.person_outline,
                                                        color: Colors.white,
                                                      ),
                                                      border: InputBorder.none,
                                                      hintText: "Username",
                                                      hintStyle: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15.0),
                                                      contentPadding: const EdgeInsets
                                                          .only(
                                                          top: 30.0,
                                                          right: 30.0,
                                                          bottom: 30.0,
                                                          left: 5.0),
                                                    ),
                                                    validator: (val) =>
                                                    val.isEmpty
                                                        ? 'Email can\'t be empty.'
                                                        : null,
                                                    onSaved: (val) =>
                                                    _email = val,
                                                    key: new Key('email'),
                                                    controller: emailController,
                                                  ),
                                                ),

                                                new Container(
                                                  decoration: new BoxDecoration(
                                                    border: new Border(
                                                      bottom: new BorderSide(
                                                        width: 0.5,
                                                        color: Colors.white24,
                                                      ),
                                                    ),
                                                  ),
                                                  child: new TextFormField(
                                                    obscureText: true,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    decoration: new InputDecoration(
                                                      icon: new Icon(
                                                        Icons.lock_outline,
                                                        color: Colors.white,
                                                      ),
                                                      border: InputBorder.none,
                                                      hintText: "Password",
                                                      hintStyle: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15.0),
                                                      contentPadding: const EdgeInsets
                                                          .only(
                                                          top: 30.0,
                                                          right: 30.0,
                                                          bottom: 30.0,
                                                          left: 5.0),
                                                    ),
                                                    validator: (val) =>
                                                    val.isEmpty
                                                        ? 'Password can\'t be empty.'
                                                        : null,
                                                    onSaved: (val) =>
                                                    _password = val,
                                                    key: new Key('password'),
                                                    controller: passwordController,
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),

                                  new FlatButton(
                                    padding: const EdgeInsets.only(
                                      top: 160.0,
                                    ),
                                    onPressed: null,//validateAndSubmit2(),
                                    child: new Text(
                                      "Don't have an account? Sign Up",
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: new TextStyle(
                                          fontWeight: FontWeight.w300,
                                          letterSpacing: 0.5,
                                          color: Colors.white,
                                          fontSize: 12.0),
                                    ),
                                  ),
                                ],
                              ),
                              animationStatus == 0
                                  ? new Padding(
                                padding: const EdgeInsets.only(bottom: 50.0),
                                child: new InkWell(
                                    onTap: () {
                                      setState(() {
                                        animationStatus = 1;
                                      });
                                      _playAnimation();
                                    },
                                    child: new SignIn()),
                                  )
                                  : new StaggerAnimation(
                                buttonController: _loginButtonController.view,
                                auth: widget.auth,
                                onSignIn: () => _updateAuthStatus(AuthStatus.signedIn),
                                onError:  () {
                                  setState(() {
                                    animationStatus = 0;
                                  });
                                  _loginButtonController.dispose();
                                  _loginButtonController = new AnimationController(
                                      duration: new Duration(milliseconds: 4000), vsync: this);
                                  _showToast(context,globals.get_auth_err());
                                },//_showToast(context,globals.get_auth_err()),
                                formType: "login",
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            ],
                          ),
                        ],
                      )));},),
            )));
        break;
      case AuthStatus.signedIn:
        //Navigator.pushNamed(context, "/home");
        return new HomeScreen(
            auth: widget.auth,
            onSignOut: () => _updateAuthStatus(AuthStatus.notSignedIn)
        );
        break;
    }
  }
  void _showToast(BuildContext context, String text){
    flush = Flushbar<bool>() // <bool> is the type of the result passed to dismiss() and collected by show().then((result){})
      ..title = "Sign In Error"
      ..message = text
      ..duration = Duration(seconds:10)
      ..icon = Icon(
        Icons.info_outline,
        color: Colors.blue,
      )
      ..mainButton = FlatButton(
        onPressed: () {
          flush.dismiss(true); // result = true
        },
        child: Text(
          "DISMISS",
          style: TextStyle(color: Colors.amber),
        ),
      )
      ..show(context).then((result) {
        setState(() { // setState() is optional here
          _wasButtonClicked = result;
        });
      });
  }
  /*void _showToast(BuildContext context, String text) {
    setState(() {
      animationStatus = 0;
    });
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      new SnackBar(
        duration: Duration(seconds: 1),

        content: new Text(text),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }*/
}
