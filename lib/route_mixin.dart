import 'package:flutter/widgets.dart';

import 'route_lifecycle_observer.dart';

/// @author newtab on 2021/5/7

mixin RouteMixin<T extends StatefulWidget> on State<T> implements RouteLifecycleStateChanged, WidgetsBindingObserver {
  String getRouteName();

  static RouteLifecycleObserver getRouteLifecycleObserver() {
    return RouteLifecycleObserver.getInstance();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    init();
    if (getRouteName().isNotEmpty) {
      RouteLifecycleObserver.getInstance().addObserver(getRouteName(), this);
    }
    resumed();
  }

  @override
  void didChanged(CurrentState state, Route currentRoute) {
    if (state == CurrentState.inactive) {
      inactive();
    } else if (state == CurrentState.resumed) {
      resumed();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    if (getRouteName().isNotEmpty) {
      RouteLifecycleObserver.getInstance().removeObserver(getRouteName(), this);
    }
    disposed();
    super.dispose();
  }

  void init() {}

  void inactive() {}

  void resumed() {}

  void disposed() {}

  @override
  void didChangeAccessibilityFeatures() {}

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (RouteLifecycleObserver.getInstance().isOnStackTop(getRouteName(), this)) {
      if (state == AppLifecycleState.resumed) {
        resumed();
      } else if (state == AppLifecycleState.inactive) {
        inactive();
      } else if (state == AppLifecycleState.detached) {
        disposed();
      }
    }
  }

  @override
  void didChangeLocales(List<Locale>? locales) {}

  @override
  void didChangeMetrics() {}

  @override
  void didChangePlatformBrightness() {}

  @override
  void didChangeTextScaleFactor() {}

  @override
  void didHaveMemoryPressure() {}

  @override
  Future<bool> didPopRoute() {
    return Future<bool>.value(false);
  }

  @override
  Future<bool> didPushRoute(String route) {
    return Future<bool>.value(false);
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    return didPushRoute(routeInformation.location!);
  }
}
