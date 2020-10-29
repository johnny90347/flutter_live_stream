import 'package:flutter/material.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter_live_stream/core/controllers/live_chat_room_controller.dart';
import 'package:flutter_live_stream/core/services/service_module.dart';
import 'package:flutter_live_stream/models/index.dart';

class LiveStreamFijk extends StatefulWidget {
  @override
  _LiveStreamFijkState createState() => _LiveStreamFijkState();
}

class _LiveStreamFijkState extends State<LiveStreamFijk> {
  final systemService = Get.find<SystemInfoService>(); //系統資訊
  final ctr = Get.find<LiveChatRoomController>();

  final FijkPlayer player = FijkPlayer();
  List<VideoDetailPart> _videoSrcList;
  String _currentUrl; // 現在的直播流

  @override
  void initState() {
    super.initState();


//    _videoSrcList = ctr.videos.value;

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
    player.setDataSource('rtmp:$_currentUrl', autoPlay: true);


    //音量監聽
    ctr.currentVideoVolume.listen((volume) {
      player.setVolume(volume);
    });
  }

  @override
  void dispose() {
    super.dispose();
    player.release();
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
  Widget build(BuildContext context) {
    return Container(
      child: FijkView(
        height: systemService.screenMaxHeight,
        width: systemService.screenMaxWidth,
        player: player,
        fit: FijkFit.cover,
      ),
    );
  }
}
