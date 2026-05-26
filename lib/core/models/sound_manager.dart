import 'package:audioplayers/audioplayers.dart';

class SoundManager {

  static final AudioPlayer _player = AudioPlayer();

  static Future<void> playSuccess() async {
    await _player.stop();
    await _player.play(AssetSource('sounds/success.mp3'));
  }

  static Future<void> playSessionComplete() async {
    await _player.stop();
    await _player.play(AssetSource('sounds/completion.mp3'));
  }

  static Future<void> playError() async {
    await _player.stop();
    await _player.play(AssetSource('sounds/error.mp3'), volume: 0.5);
  }
}