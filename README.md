# route_lifecycle

a new way to manage routes lifecycle.

Route路由管理插件


## install

### Add to pubspec

the latest version is [![pub package](https://img.shields.io/pub/v/route_lifecycle.svg)](https://pub.dartlang.org/packages/route_lifecycle)

```yaml
dependencies:
  route_lifecycle: $latest_version
```


### import in dart code

```dart
import 'package:route_lifecycle/route_lifecycle.dart';
```


## Usage

```dart

/// config navigatorObservers

MaterialApp(
      navigatorObservers: [
        ...
        RouteMixin.getRouteLifecycleObserver(),
      ],
    );

```

```dart

with RouteMixin<T> 

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
        },
        child: Container(
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
  void resumed() {
    super.resumed();
  }

  @override
  void disposed() {
    super.disposed();
  }

  @override
  void inactive() {
    super.inactive();
  }
}

```
