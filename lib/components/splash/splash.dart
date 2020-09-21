import 'package:flutter/material.dart';
import 'package:flutter_live_stream/core/services/service_module.dart';
import 'package:flutter_live_stream/core/states/state_module.dart';

class Splash extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<Splash> {
  @override
  void initState() {
    // 使用此方法配合"WhenRebuilder"
    RM.get<GlobalState>().setState((s) => s.getLoginInfo(), shouldAwait: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Splash'),
      ),
      body: Center(
        child: Column(
          children: [
            WhenRebuilder<GlobalState>(
              observe: () => RM.get<GlobalState>(),
              onSetState: (context, globalRM) {
                globalRM.whenConnectionState(
                    onIdle: () => print('Idle'),
                    onWaiting: () => print('onWaiting'),
                    onData: (data) => print('onData'),
                    onError: (error) => (data) => print('onData'));
              },
              onIdle: () => Text('啟動頁'),
              onWaiting: () => Text('取得資料中'),
              onData: (data) => Text('拿到資料了'),
              onError: (error) => Text('拿到資料了'),
            ),
            RaisedButton(
                child: Text('去首頁'),
                onPressed: () {
                  // final routerService = locator<RouterService>();
                  // routerService.goToPage(
                  //     context: context, routeName: homeRoute);
                })
          ],
        ),
      ),
    );
  }
}

//
