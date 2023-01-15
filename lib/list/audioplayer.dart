import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:learn_flutter/common/commons.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class AudioPlayerRoute extends StatefulWidget {
  const AudioPlayerRoute({super.key});

  @override
  State<AudioPlayerRoute> createState() => _AudioPlayerRouteState();
}

class _AudioPlayerRouteState extends State<AudioPlayerRoute>
    with TickerProviderStateMixin {
  late AnimationController _coverController;
  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _coverController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat(reverse: false);
    _progressController =
        AnimationController(vsync: this, duration: const Duration(seconds: 201))
          ..addListener(() {
            setState(() {});
          })
          ..forward();
  }

  @override
  void dispose() {
    _coverController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var rotateImage = RotationTransition(
      turns: _coverController,
      child: Image.asset(
        "images/01.webp",
        fit: BoxFit.cover,
      ),
    );
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
            _MyMenuAction(),
          ],
        ),
        body: Column(
          children: [
            const Spacer(flex: 1),
            Center(child: _buildAudioCoverWidget(rotateImage)),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Draft Punk",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black87),
                ),
              ),
            ),
            const Center(
              child: Text(
                "instant crush",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
            const Spacer(flex: 2),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "0:00",
                    style: TextStyle(fontSize: 16, color: Colors.black45),
                  ),
                ),
                Flexible(
                  child: LinearProgressIndicator(
                    value: _progressController.value,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "3:21",
                    style: TextStyle(fontSize: 16, color: Colors.black45),
                  ),
                ),
              ],
            ),
            const Spacer(flex: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.fast_rewind,
                  size: 48,
                  color: Colors.black45,
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.pause,
                    size: 72,
                    color: Colors.black54,
                  ),
                ),
                Icon(
                  Icons.fast_forward,
                  size: 48,
                  color: Colors.black45,
                )
              ],
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildAudioCoverWidget(Widget image) {
    var ring = SizedBox(
      width: 220,
      height: 220,
      child: ClipPath(
        clipper: _MyPathClipper(),
        child: image,
      ),
    );
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(60, 60, 20, 20),
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(
                sigmaX: 10, sigmaY: 10, tileMode: TileMode.decal),
            child: ring,
          ),
        ),
        ring,
      ],
    );
  }
}

class _MyPathClipper extends CustomClipper<Path> {
  static const double hollowRatio = 1 / 4;
  @override
  Path getClip(Size size) {
    var path = Path();
    path.addOval(Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width * hollowRatio,
        height: size.height * hollowRatio));
    path.addOval(Offset.zero & size);
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}

class _MyMenuAction extends StatelessWidget {
  const _MyMenuAction({super.key});

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
