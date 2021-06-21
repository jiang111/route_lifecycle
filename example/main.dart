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
      home: HomePage(),
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
          Navigator.of(context).push(
            new CupertinoPageRoute(builder: (context) => HomePage2(), settings: RouteSettings(name: '/a2', arguments: Map())),
          );
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
    return "/";
  }

  @override
  void init() {
    super.init();
    print(".....${getRouteName()} init");
  }

  @override
  resumed() {
    print(".....${getRouteName()} resumed");
    return super.resumed();
  }

  @override
  void disposed() {
    print(".....${getRouteName()} disposed");
    super.disposed();
  }

  @override
  inactive() {
    print(".....${getRouteName()} inactive");
    return super.inactive();
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
          Navigator.of(context).push(
            new CupertinoPageRoute(builder: (context) => Home3Page(), settings: RouteSettings(name: '/a3', arguments: Map())),
          );
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
  void disposed() {
    print(".....${getRouteName()} disposed");
    super.disposed();
  }

  @override
  resumed() {
    print(".....${getRouteName()} resumed");
    return super.resumed();
  }

  @override
  inactive() {
    print(".....${getRouteName()} inactive");
    return super.inactive();
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
          Navigator.of(context).pop();
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
  resumed() {
    print(".....${getRouteName()} resumed");
    return super.resumed();
  }

  @override
  void disposed() {
    print(".....${getRouteName()} disposed");
    super.disposed();
  }

  @override
  inactive() {
    print(".....${getRouteName()} inactive");
    return super.inactive();
  }

  @override
  void init() {
    super.init();
    print(".....${getRouteName()} init");
  }
}
