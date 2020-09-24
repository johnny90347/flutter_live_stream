import 'package:flutter/material.dart';
import 'package:flutter_live_stream/core/controllers/global_controller/global_controller.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:get/get.dart';

// 直播
class LiveStream extends StatefulWidget {
  @override
  _LiveStreamState createState() => _LiveStreamState();
}

class _LiveStreamState extends State<LiveStream> {

  String urlToStreamVideo;
  final double playerWidth = 640;
  final double playerHeight = 360;


  VlcPlayerController _videoViewController;

  @override
  void initState() {

//    urlToStreamVideo ='http:${Get.put(GlobalController()).videos[0].Flv}' ;
//
//    _videoViewController = new VlcPlayerController(onInit: () {
//      _videoViewController.play();
//    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(
        image: AssetImage('assets/images/girl.jpg'),
        fit: BoxFit.fitWidth,
      ),
//    height: playerHeight,
//      width: playerWidth,
//    child: VlcPlayer(
//      aspectRatio: 16 / 9,
//      url: urlToStreamVideo,
//      controller: _videoViewController,
//      placeholder: Center(child: CircularProgressIndicator()),
//    )
    );
  }
}