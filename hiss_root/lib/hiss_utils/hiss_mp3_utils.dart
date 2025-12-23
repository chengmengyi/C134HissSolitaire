import 'package:audioplayers/audioplayers.dart';

import 'hiss_root_staorage.dart';

enum HissMp3Type{
  bgm,
  chupai, //出牌
  click, //点击
  cunqian, //存钱罐
  fanpai, //翻牌
  prop, //道具弹窗
  super_prop, //超级道具
  win, //胜利
  money, //金币
  puzzle, //实物碎片
}

class HissMp3Utils{
  static final HissMp3Utils _hissMp3Utils=HissMp3Utils();
  static HissMp3Utils get instance => _hissMp3Utils;

  final AudioPlayer _bgmPlayer=AudioPlayer();

  initPlayer()async{
    final audioContext = AudioContext(
      android: const AudioContextAndroid(
        isSpeakerphoneOn: true,
        stayAwake: false,
        contentType: AndroidContentType.music,
        usageType: AndroidUsageType.media,
        audioFocus: AndroidAudioFocus.none,
      ),
      iOS: AudioContextIOS(
        category: AVAudioSessionCategory.playback,
        options: {
          AVAudioSessionOptions.mixWithOthers
        },
      ),
    );
    await AudioPlayer.global.setAudioContext(audioContext);
  }

  setPlayBgm(){
    if(playBgmKey.getData()){
      playBgmKey.saveData(false);
      _bgmPlayer.pause();
    }else{
      playBgmKey.saveData(true);
      playBgm();
    }
  }

  playBgm(){
    if(playBgmKey.getData()){
      _bgmPlayer.setReleaseMode(ReleaseMode.loop);
      _bgmPlayer.play(AssetSource("${HissMp3Type.bgm.name}.MP3"));
    }
  }

  stopBgm(){
    if(_bgmPlayer.state==PlayerState.playing){
      _bgmPlayer.pause();
    }
  }

  setPlayOtherMp3(){
    playOtherMp3Key.saveData(!playOtherMp3Key.getData());
  }

  playOtherMp3(HissMp3Type mp3Type){
    if(playOtherMp3Key.getData()){
      AudioPlayer audio=AudioPlayer();
      if(mp3Type==HissMp3Type.super_prop){
        audio.setVolume(100);
      }
      audio.onPlayerStateChanged.listen((state){
        if(state==PlayerState.completed){
          audio.dispose();
        }
      });
      audio.play(AssetSource("${mp3Type.name}.MP3"));
    }
  }
}