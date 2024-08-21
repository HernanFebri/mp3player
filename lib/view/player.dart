import 'package:audio_player/constants/colors.dart';
import 'package:audio_player/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Player extends StatelessWidget {
  const Player({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.music_note),
            )),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Music Name',
                      style: ourStyle(
                        color: bgDarkColor,
                        family: bold,
                        size: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Artist Name',
                      style: ourStyle(
                        color: bgDarkColor,
                        family: regular,
                        size: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Text(
                          "0:0",
                          style: ourStyle(
                            color: bgDarkColor,
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            value: 0.0,
                            onChanged: (newValue) {},
                          ),
                        ),
                        Text(
                          "04:00",
                          style: ourStyle(
                            color: bgDarkColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
