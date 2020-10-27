import 'package:flutter/material.dart';
import 'package:flutter_live_stream/core/controllers/global_controller.dart';
import 'package:flutter_live_stream/core/services/service_module.dart';
import 'package:flutter_live_stream/models/index.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:get/get.dart';

// 直播
class LiveStream extends StatefulWidget {
  @override
  _LiveStreamState createState() => _LiveStreamState();
}

class _LiveStreamState extends State<LiveStream> {
  final systemService = Get.find<SystemInfoService>(); //系統資訊

  List<VideoDetailPart> _videoSrcList;
  String _currentUrl; // 現在的直播流
  VlcPlayerController _videoViewController;

  @override
  void initState() {

    _videoSrcList = [
      VideoDetailPart.fromJson({
        "Flv": '//tw.2q3k.cn/obs/018.flv',
        "Hls": '//tw.2q3k.cn/obs/018/playlist.m3u8',
        "Priority": 0
      }),
      VideoDetailPart.fromJson({
        "Flv": '//tw.2q3k.cn/obs/018.flv',
        "Hls": '//tw.2q3k.cn/obs/018/playlist.m3u8',
        "Priority": 1
      }),
      VideoDetailPart.fromJson({
        "Flv": '//tw.pubcc.cn/obs/018.flv',
        "Hls": '//tw.pubcc.cn/obs/018/playlist.m3u8',
        "Priority": 2
      })
    ];

    _currentUrl = _getUrl(0)?.Flv;

    _videoViewController = new VlcPlayerController(onInit: () {
      _videoViewController.play();
    });


//    urlToStreamVideo ='http:${Get.put(GlobalController()).videos[0].Flv}' ;
//

    super.initState();
  }


// 直播url
  VideoDetailPart _getUrl(int priority){
    for(VideoDetailPart v in _videoSrcList){
      if(v.Priority == priority){
        return v;
      }
    }
  }


  @override
  void dispose() {
   _videoViewController.dispose();
    super.dispose();
  }

//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: VlcPlayer(
//        aspectRatio: 1 / 1.63,
//        url: 'rtmp:$_currentUrl',
//        controller: _videoViewController,
//        isLocalMedia: false,
//        placeholder: Center(child: CircularProgressIndicator()),
//      ),
//    );
//  }

 @override
  Widget build(BuildContext context){

    return Image(image: AssetImage('assets/images/girl.jpg'),
    fit: BoxFit.fitHeight,
    );
 }
}
