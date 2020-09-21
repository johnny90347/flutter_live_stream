import 'package:flutter/material.dart';
import 'package:flutter_live_stream/core/services/service_module.dart';

class Splash extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Splash'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: Text('啟動頁'),
            ),
            RaisedButton(
                child: Text('去首頁'),
                onPressed: () {
                  final routerService = locator<RouterService>();
                  routerService.goToPage(
                      context: context, routeName: homeRoute);
                })
          ],
        ),
      ),
    );
  }
}

//
