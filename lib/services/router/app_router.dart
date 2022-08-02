import 'package:flutter/material.dart';
import 'package:tasks_app/screens/recycle_bin.dart';
import 'package:tasks_app/services/router/router_names.dart';

import '../../screens/tabs_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case tabsRoute:
        return MaterialPageRoute(builder: (_) => const TabsScreen());
      case recycleBinRoute:
        return MaterialPageRoute(builder: (_) => const RecycleBin());
      default:
        return null;
    }
  }
}
