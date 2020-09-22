import 'package:flutter/material.dart';
import 'package:flutter_live_stream/components/home/home.dart';
import 'package:flutter_live_stream/components/live_stream/live_stream.dart';
import 'package:flutter_live_stream/components/splash/splash.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

const String splash = '/';
const String liveStreamRoute = '/liveStream';
const String homeRoute = '/home';

class RouterService {
  // 路由配置(不使用此方法做跳轉方法)
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Splash());
      case '/liveStream':
        return MaterialPageRoute(builder: (_) => LiveStream());
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  // 跳轉頁面實際呼叫的方法
  void goToPage({@required BuildContext context,@required String routeName}){
    switch (routeName) {
      case '/':
      return;
      case '/liveStream':
      Navigator.pushNamed(context, liveStreamRoute);
      return;
      case '/home':
      Navigator.of(context).pushNamedAndRemoveUntil(homeRoute, (Route<dynamic> route) => false);
      return ;
      default:
        return ;
    }
  }
}
