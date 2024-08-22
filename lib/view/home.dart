import 'package:audio_player/constants/colors.dart';
import 'package:audio_player/constants/text_style.dart';
import 'package:audio_player/controllers/player_controller.dart';
import 'package:audio_player/view/player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());

    return Scaffold(
      backgroundColor: bgDarkColor,
      appBar: AppBar(
        backgroundColor: bgDarkColor,
        actions: const [],
        title: Center(
          child: Text(
            "Musik Anda",
            style: ourStyle(
              family: bold,
              size: 18,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller.searchController,
              style: ourStyle(color: whiteColor),
              decoration: InputDecoration(
                hintText: 'Cari Lagu...',
                hintStyle: ourStyle(color: whiteColor.withOpacity(0.5)),
                prefixIcon: const Icon(Icons.search, color: whiteColor),
                filled: true,
                fillColor: bgColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.filteredSongs.isEmpty) {
          return Center(
            child: Text(
              "Tidak ada lagu ditemukan",
              style: ourStyle(),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: controller.filteredSongs.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.only(
                    bottom: 8,
                  ),
                  child: Obx(
                    () => ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      tileColor: bgColor,
                      title: Text(
                        controller.filteredSongs[index].displayNameWOExt,
                        style: ourStyle(family: bold, size: 15),
                      ),
                      subtitle: Text(
                        "${controller.filteredSongs[index].artist}",
                        style: ourStyle(family: regular, size: 12),
                      ),
                      leading: QueryArtworkWidget(
                        id: controller.filteredSongs[index].id,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: const Icon(
                          Icons.music_note,
                          color: whiteColor,
                          size: 32,
                        ),
                      ),
                      trailing: controller.playIndex.value == index &&
                              controller.isPlaying.value
                          ? const Icon(
                              Icons.play_arrow,
                              color: whiteColor,
                              size: 26,
                            )
                          : null,
                      onTap: () {
                        Get.to(
                          () => Player(
                            data: controller.filteredSongs,
                          ),
                          transition: Transition.downToUp,
                        );
                        controller.playSong(
                            controller.filteredSongs[index].uri, index);
                      },
                    ),
                  ),
                );
              },
            ),
          );
        }
      }),
    );
  }
}
