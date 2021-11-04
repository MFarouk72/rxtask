import 'dart:async';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';

final pathToSaveAudio = 'audio_example.aac';
class RecordAudioBloc {
  BehaviorSubject<String> audioPathSubject = BehaviorSubject.seeded("");
  static String? mPath;
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecorderInitialized = false;
  bool get isRecording => _audioRecorder!.isRecording;

  Future _record(String path) async{
    if(!_isRecorderInitialized) return;
    var tempDir = await getTemporaryDirectory();
    mPath = '${tempDir.path}/$path.aac';
    await _audioRecorder!.startRecorder(toFile: mPath);
    audioPathSubject.sink.add(mPath!);
  }
  Future _stop() async{
    if(!_isRecorderInitialized) return;
    await _audioRecorder!.stopRecorder();
  }

  Future toggleRecording(String path) async{
   if(_audioRecorder!.isStopped){
     await _record(path);
   } else {
     await _stop();
   }
  }

  Future init() async{
    _audioRecorder = FlutterSoundRecorder();
    final status = await Permission.microphone.request();
    if(status != PermissionStatus.granted){
      throw RecordingPermissionException("mic permission is not granted");
    }

    await _audioRecorder!.openAudioSession();
    _isRecorderInitialized =true;
  }

  void dispose() {
    if(!_isRecorderInitialized) return;
    _audioRecorder!.closeAudioSession();
    _audioRecorder = null;
    _isRecorderInitialized = false;
    audioPathSubject.close();
  }

  // Future<IOSink> createFile() async {
  //   var tempDir = await getTemporaryDirectory();
  //   _mPath = '${tempDir.path}/flutter_sound_example.pcm';
  //   var outputFile = File(_mPath!);
  //   if (outputFile.existsSync()) {
  //     await outputFile.delete();
  //   }
  //   return outputFile.openWrite();
  // }

  // BehaviorSubject<AudioStatus> audioStatusSubject = BehaviorSubject();
  //
  // // StreamSink<AudioStatus> get audioStatusSink => audioStatusSubject.sink;
  //
  // // Stream<AudioStatus> get audioStatusStream => audioStatusSubject.stream;
  //
  // //====================================
  // BehaviorSubject<PlayFromUrlStatus> playFromUrlStatusSubject = BehaviorSubject();
  //
  // // StreamSink<PlayFromUrlStatus> get playFromUrlStatusSink => playFromUrlStatusSubject.sink;
  // //
  // // Stream<PlayFromUrlStatus> get playFromUrlStatusStream => playFromUrlStatusSubject.stream;
  //
  // //====================================
  // Recording recording = new Recording();
  // String audioPath = '';
  // String recorderLength = '';
  // AudioPlayer audioPlayer = AudioPlayer();
  // late AudioPlayer _audioPlayer;
  //
  // startRecord() async {
  //   if (await AudioRecorder.hasPermissions) {
  //     audioStatusSubject.sink.add(AudioStatus.RECORDING);
  //
  //     await AudioRecorder.start();
  //     recording = new Recording(
  //         duration: new Duration(),
  //         path: "",
  //         audioOutputFormat: AudioOutputFormat.AAC);
  //   } else {
  //     Permission.microphone.request();
  //     audioStatusSubject.sink.add(AudioStatus.NULL);
  //   }
  // }
  //
  // stopRecord() async {
  //   audioStatusSubject.sink.add(AudioStatus.RECORDED);
  //   var recording = await AudioRecorder.stop();
  //   audioPath = recording.path;
  //   print('${audioPath} adiooooooooooooooooooooooo');
  //   recorderLength = recording.duration.toString();
  // }
  //
  // void startPlaySound() async {
  //   audioStatusSubject.sink.add(AudioStatus.PLAYING);
  //   AudioPlayer.logEnabled = true;
  //   await audioPlayer.play(audioPath).whenComplete(
  //           () => audioStatusSubject.sink.add(AudioStatus.STOP_PLAYING));
  // }
  //
  // void stopPlaySound() async {
  //   audioStatusSubject.sink.add(AudioStatus.STOP_PLAYING);
  //   AudioPlayer.logEnabled = true;
  //   await audioPlayer.stop();
  // }
  //
  // void startPlaySoundFromUrl(String url) async {
  //   playFromUrlStatusSubject.sink.add(PlayFromUrlStatus.PLAYING);
  //   AudioPlayer.logEnabled = true;
  //   await audioPlayer.play(url).whenComplete(() =>
  //       playFromUrlStatusSubject.sink.add(PlayFromUrlStatus.STOP_PLAYING));
  //   // audioPlayer.onPlayerStateChanged.listen((event) {
  //   //
  //   //  });
  // }
  //
  // void stopPlaySoundFromUrl() async {
  //   playFromUrlStatusSubject.sink.add(PlayFromUrlStatus.STOP_PLAYING);
  //   AudioPlayer.logEnabled = true;
  //   await audioPlayer.stop();
  // }
  //
  // clearAudio() {
  //   audioStatusSubject.sink.add(AudioStatus.NULL);
  //   recording = new Recording();
  //   audioPath = '';
  //   recorderLength = '';
  //   audioPlayer = AudioPlayer();
  // }
  //
  // void dispose() {
  //   audioStatusSubject.close();
  //   playFromUrlStatusSubject.close();
  // }
}