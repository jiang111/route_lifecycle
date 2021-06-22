import 'package:flutter/widgets.dart';

import 'route_lifecycle_observer.dart';

/// @author newtab on 2021/5/7

mixin RouteMixin<T extends StatefulWidget> on State<T>
    implements RouteLifecycleStateChanged, WidgetsBindingObserver {
  String getRouteName();

  late CurrentState currentState;

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
    resume();
  }

  @override
  void didChanged(CurrentState state, Route currentRoute) {
    if (state == CurrentState.inactive) {
      inactive();
    } else if (state == CurrentState.resume) {
      resume();
    }
  }

  @override
  void dispose() {
    if (currentState == CurrentState.init ||
        currentState == CurrentState.resume) {
      inactive();
    }
    WidgetsBinding.instance?.removeObserver(this);
    if (getRouteName().isNotEmpty) {
      RouteLifecycleObserver.getInstance().removeObserver(getRouteName(), this);
    }
    stop();
    super.dispose();
  }

  @mustCallSuper
  void init() {
    currentState = CurrentState.init;
  }

  @mustCallSuper
  void inactive() {
    currentState = CurrentState.inactive;
  }

  @mustCallSuper
  void resume() {
    currentState = CurrentState.resume;
  }

  @mustCallSuper
  void stop() {
    currentState = CurrentState.stop;
  }

  @override
  void didChangeAccessibilityFeatures() {}

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (RouteLifecycleObserver.getInstance()
        .isOnStackTop(getRouteName(), this)) {
      if (state == AppLifecycleState.resumed) {
        resume();
      } else if (state == AppLifecycleState.inactive) {
        inactive();
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
