import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  static final AudioManager instance = AudioManager._internal();

  AudioManager._internal();

  final List<AudioPlayer> _players = [];

  AudioPlayer? _activePlayer;

  // Player khusus backsound Abjad
  final AudioPlayer abjadPlayer = AudioPlayer();

  bool abjadStarted = false;

  void register(AudioPlayer player) {
    if (!_players.contains(player)) {
      _players.add(player);
    }
  }

  void unregister(AudioPlayer player) {
    _players.remove(player);

    if (_activePlayer == player) {
      _activePlayer = null;
    }
  }

  void setActivePlayer(AudioPlayer player) {
    _activePlayer = player;
  }

  // =========================
  // BACKSOUND ABJAD
  // =========================

  Future<void> playAbjadBacksound() async {
    if (!abjadStarted) {
      abjadStarted = true;

      await abjadPlayer.setReleaseMode(ReleaseMode.loop);
      await abjadPlayer.setVolume(1.0);

      await abjadPlayer.play(
        AssetSource('backsound/abjad.mp3'),
      );
    } else {
      await abjadPlayer.resume();
    }

    _activePlayer = abjadPlayer;
  }

  // =========================
  // STOP SEMUA SOUND
  // =========================

  Future<void> stopAll() async {
    // Stop player yang terdaftar
    for (final player in List<AudioPlayer>.from(_players)) {
      await player.stop();
    }

    // Stop player Abjad
    await abjadPlayer.stop();
  }

  // =========================
  // RESUME PLAYER AKTIF
  // =========================

  Future<void> resumeActivePlayer() async {
    if (_activePlayer != null) {
      await _activePlayer!.resume();
    }
  }
}