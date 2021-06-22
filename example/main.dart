/// @author newtab on 2021/5/7

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:route_lifecycle/route_lifecycle.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/main": (context) => HomePage(),
        "/a2": (context) => HomePage2(),
        "/a3": (context) => Home3Page(),
      },
      initialRoute: "/main",
      navigatorObservers: [
        RouteMixin.getRouteLifecycleObserver(),
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteMixin<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed("/a2");
        },
        child: Container(
          child: Center(
            child: Text("11111111111"),
          ),
        ),
      ),
    );
  }

  @override
  String getRouteName() {
    return "/main";
  }

  @override
  void init() {
    super.init();
  }

  @override
  void resume() {
    super.resume();
  }

  @override
  void stop() {
    super.stop();
  }

  @override
  void inactive() {
    super.inactive();
  }
}

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> with RouteMixin<HomePage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed("/a3");
        },
        child: Container(
          child: Center(
            child: Text("2222222222222222"),
          ),
        ),
      ),
    );
  }

  @override
  void init() {
    super.init();
    print(".....${getRouteName()} init");
  }

  @override
  String getRouteName() {
    return "/a2";
  }

  @override
  void stop() {
    super.stop();
    print(".....${getRouteName()} stoped");
  }

  @override
  void resume() {
    print(".....${getRouteName()} resumed");
    super.resume();
  }

  @override
  void inactive() {
    print(".....${getRouteName()} inactive");
    super.inactive();
  }
}

class Home3Page extends StatefulWidget {
  const Home3Page({Key? key}) : super(key: key);

  @override
  _Home3PageState createState() => _Home3PageState();
}

class _Home3PageState extends State<Home3Page> with RouteMixin<Home3Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: InkWell(
        onTap: () {
          Navigator.of(context)
              .popUntil((route) => route.settings.name == "/main");
        },
        child: Container(
          child: Center(
            child: Text("33333333"),
          ),
        ),
      ),
    );
  }

  @override
  String getRouteName() {
    return "/a3";
  }

  @override
  void resume() {
    print(".....${getRouteName()} resumed");
    super.resume();
  }

  @override
  void stop() {
    print(".....${getRouteName()} stoped");
    super.stop();
  }

  @override
  void inactive() {
    print(".....${getRouteName()} inactive");
    super.inactive();
  }

  @override
  void init() {
    super.init();
    print(".....${getRouteName()} init");
  }
}
