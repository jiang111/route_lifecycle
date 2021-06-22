# route_lifecycle

a new way to manage routes lifecycle.

Route路由生命周期管理插件


![](https://raw.githubusercontent.com/jiang111/route_lifecycle/master/image/lifecycle.png)


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

/// with RouteMixin<T> 

class _HomePageState extends State<HomePage> with RouteMixin<HomePage> {
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


```
