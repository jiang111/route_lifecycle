import 'package:flutter/cupertino.dart';

/// @author newtab on 2021/5/7

class RouteLifecycleObserver extends NavigatorObserver {
  static const SPLIT = "@&&@";
  Map<String, RouteLifecycleStateChanged> routeLifecycleDidChanges = {};

  static RouteLifecycleObserver _instance = RouteLifecycleObserver();
  List<Route> _historyRoutes = [];

  static RouteLifecycleObserver getInstance() {
    return _instance;
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _historyRoutes.remove(route);
    if (previousRoute != null) {
      routeStateChanged(previousRoute, CurrentState.resume);
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    _historyRoutes.remove(route);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _historyRoutes.remove(oldRoute);
    if (newRoute != null) {
      _historyRoutes.add(newRoute);
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _historyRoutes.add(route);
    if (previousRoute != null) {
      routeStateChanged(previousRoute, CurrentState.inactive);
    }
    routeStateChanged(route, CurrentState.resume);
  }

  void addObserver(String name, RouteLifecycleStateChanged routeLifecycleStateChanged) {
    routeLifecycleDidChanges[getKey(name, routeLifecycleStateChanged)] = routeLifecycleStateChanged;
  }

  String getKey(String name, RouteLifecycleStateChanged routeLifecycleStateChanged) {
    return "$name$SPLIT${routeLifecycleStateChanged.hashCode}";
  }

  void removeObserver(String name, RouteLifecycleStateChanged routeLifecycleStateChanged) {
    if (!routeLifecycleDidChanges.containsKey(getKey(name, routeLifecycleStateChanged))) return;
    routeLifecycleDidChanges.remove(getKey(name, routeLifecycleStateChanged));
  }

  void routeStateChanged(Route<dynamic> route, CurrentState targetState) {
    if (route.settings.name != null) {
      String name = route.settings.name!;
      for (String key in routeLifecycleDidChanges.keys) {
        if (name == key.split(SPLIT)[0]) {
          routeLifecycleDidChanges[key]?.didChanged(targetState, route);
        }
      }
    }
  }

  bool isOnStackTop(String routeName, RouteLifecycleStateChanged routeLifecycleStateChanged) {
    if (_historyRoutes.isEmpty) return false;
    if (routeLifecycleDidChanges.isEmpty) return false;
    if (routeLifecycleDidChanges.entries.last.key == getKey(routeName, routeLifecycleStateChanged)) {
      return routeName == _historyRoutes.last.settings.name;
    }
    return false;
  }
}

abstract class RouteLifecycleStateChanged {
  void didChanged(CurrentState state, Route currentRoute);
}

enum CurrentState {
  init,
  resume,
  inactive,
  stop,
}
