import 'package:flutter/material.dart';
import 'package:learn_flutter/common/commons.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class AudioPlayerRoute extends StatelessWidget {
  const AudioPlayerRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff6750a4),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("AudioPlayer"),
          leading: const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          actions: const [
            MyMenuAction(),
          ],
        ),
        body: const Center(
          child: Text("Audio Player"),
        ),
      ),
    );
  }
}

class MyMenuAction extends StatelessWidget {
  const MyMenuAction({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 56,
      child: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          logger.d("menu clicked");
          showShackBar(context, "menu clicked");
        },
      ),
    );
  }
}
