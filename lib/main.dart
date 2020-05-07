
import 'package:flutter/material.dart';
import 'package:reactivate/login.dart';
import 'package:reactivate/registro_empleado.dart';
import 'package:reactivate/temporal.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MaterialApp(home: prefs.getString('uid') == null ? LoginPage() : PaginaInicio(),
    routes: {
    '/inicio': (context) => PaginaInicio(),
      '/empleado': (context) => RegistroEmpleado(),
  },));
}

/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: appTheme(),
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => LoginPage(),
          //'/login': (context) => LoginPage(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/inicio': (context) => PaginaInicio(),

          //'/control' : (context) => ControlPage(),
          //'/batch' : (context) => BatchPage(),
        }
    );
  }
}

 */

/*
import 'package:flutter/material.dart';
import "package:reactivate/ui/screens/walk_screen.dart";
import 'package:reactivate/ui/screens/root_screen.dart';
import 'package:reactivate/ui/screens/sign_in_screen.dart';
import 'package:reactivate/ui/screens/sign_up_screen.dart';
import 'package:reactivate/ui/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firestore.instance.settings(persistenceEnabled: true);
  SharedPreferences.getInstance().then((prefs) {
    runApp(MyApp(prefs: prefs));
  });
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  MyApp({this.prefs});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/walkthrough': (BuildContext context) => new WalkthroughScreen(),
        '/root': (BuildContext context) => new RootScreen(),
        '/signin': (BuildContext context) => new SignInScreen(),
        '/signup': (BuildContext context) => new SignUpScreen(),
        '/main': (BuildContext context) => new MainScreen(),
      },
      theme: ThemeData(
        primaryColor: Colors.white,
        primarySwatch: Colors.grey,
      ),
      home: _handleCurrentScreen(),
    );
  }

  Widget _handleCurrentScreen() {
    bool seen = (prefs.getBool('seen') ?? false);
    if (seen) {
      return new RootScreen();
    } else {
      return new WalkthroughScreen(prefs: prefs);
    }
  }
}
*/
