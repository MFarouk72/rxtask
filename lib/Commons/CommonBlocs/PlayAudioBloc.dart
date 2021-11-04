import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_sound/flutter_sound.dart';

class PlayAudioBloc {
  FlutterSoundPlayer? _audioPlayer;
  bool get isPlaying => _audioPlayer!.isPlaying;
  Future _play(String path) async{
    await _audioPlayer!.startPlayer(
      fromURI:path,
      // whenFinished: whenFinished,
    );
  }
  Future _stop() async{
    await _audioPlayer!.stopPlayer();
  }

  Future togglePlayStop(String path) async{
    if(_audioPlayer!.isStopped){
      await _play(path);
    } else {
      await _stop();
    }
  }

  Future init() async{
    _audioPlayer = FlutterSoundPlayer();
    final status = await Permission.microphone.request();
    if(status != PermissionStatus.granted){
      throw RecordingPermissionException("mic permission is not granted");
    }

    await _audioPlayer!.openAudioSession();

  }

  void dispose() {
    _audioPlayer!.closeAudioSession();
    _audioPlayer = null;

  }
}