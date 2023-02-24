import 'package:audio_session/audio_session.dart';
import 'package:haishin_kit/audio_settings.dart';
import 'package:haishin_kit/audio_source.dart';
import 'package:haishin_kit/rtmp_connection.dart';
import 'package:haishin_kit/rtmp_stream.dart';
import 'package:haishin_kit/video_settings.dart';
import 'package:haishin_kit/video_source.dart';
import 'package:permission_handler/permission_handler.dart';

class IosStreamRepository {
  late final RtmpConnection _connection;
  late final RtmpStream _stream;
  late final AudioSession _session;
  CameraPosition _cameraPosition = CameraPosition.back;

  late final String _streamId;

  RtmpConnection get connection => _connection;
  RtmpStream get stream => _stream;
  CameraPosition get cameraPosition => _cameraPosition;

  Future<void> initIosPlatform() async {
    await Permission.camera.request();
    await Permission.microphone.request();

    _session = await AudioSession.instance;
    await _session.configure(const AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
      AVAudioSessionCategoryOptions.allowBluetooth,
    ));

    _connection = await RtmpConnection.create();
    _connection.eventChannel.receiveBroadcastStream().listen((event) {
      print(event["data"]["code"]);
      switch(event["data"]["code"]) {
        case 'NetConnection.Connect.Success':
          _stream.publish(_streamId);
          break;
      }
    });

    _stream = await RtmpStream.create(_connection);
    _stream.audioSettings = AudioSettings(muted: false, bitrate: 64 * 1000);
    _stream.videoSettings = VideoSettings(
      width: 480,
      height: 272,
      bitrate: 512 * 1000,
    );
    _stream.attachAudio(AudioSource());
    _stream.attachVideo(VideoSource(position: CameraPosition.back));
  }

  void startStream(String url, String streamId) {
    _connection.connect(url);
    _streamId = streamId;
  }

  void switchCamera(CameraPosition cp) {
    _cameraPosition = cp;
    _stream.attachVideo(VideoSource(position: _cameraPosition));
  }

  void stopStream() {
    _connection.close();
  }

  void dispose() {
    _connection.dispose();
    _stream.dispose();
  }
}