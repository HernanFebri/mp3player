import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  final searchController = SearchController();

  var playIndex = 0.obs;
  var isPlaying = false.obs;

  var duration = ''.obs;
  var position = ''.obs;

  var max = 0.0.obs;
  var value = 0.0.obs;

  var songList = <SongModel>[].obs; // Daftar semua lagu
  var filteredSongs = <SongModel>[].obs; // Daftar lagu yang difilter

  @override
  void onInit() {
    super.onInit();
    checkPermission();
    fetchSongs(); // Mengambil daftar lagu saat inisialisasi
    searchController.addListener(() {
      filterSongs(searchController.text);
    });
  }

  void fetchSongs() async {
    var songs = await audioQuery.querySongs(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: null,
      uriType: UriType.EXTERNAL,
    );
    songList.value = songs;
    filteredSongs.value = songs; // Awalnya tampilkan semua lagu
  }

  void filterSongs(String query) {
    if (query.isEmpty) {
      filteredSongs.value = songList;
    } else {
      filteredSongs.value = songList
          .where((song) =>
              song.displayNameWOExt.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  updatePosition() {
    audioPlayer.durationStream.listen((d) {
      duration.value = d.toString().split(".")[0];
      max.value = d!.inSeconds.toDouble();
    });
    audioPlayer.positionStream.listen((p) {
      position.value = p.toString().split(".")[0];
      value.value = p.inSeconds.toDouble();
    });
  }

  changeDurationToSeconds(seconds) {
    var duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }

  playSong(String? uri, index) {
    playIndex.value = index;
    try {
      audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(uri!),
        ),
      );
      audioPlayer.play();
      isPlaying(true);
      updatePosition();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  checkPermission() async {
    var perm = await Permission.storage.request();
    if (perm.isGranted) {
    } else {
      checkPermission();
    }
  }
}
