import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../Controller/camera_controller.dart';

class VideoPage extends StatefulWidget {
  final String filePath;

  const VideoPage({Key? key, required this.filePath}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final appCameraController = Get.put(AppCameraController());

  @override
  void dispose() {
    appCameraController.videoPlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppCameraController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Preview'),
          elevation: 0,
          backgroundColor: Colors.black26,
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                print('save the file');
              },
            )
          ],
        ),
        extendBodyBehindAppBar: true,
        body: FutureBuilder(
          future: appCameraController.initVideoPlayer(widget.filePath),
          builder: (context, state) {
            if (state.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return VideoPlayer(appCameraController.videoPlayerController!);
            }
          },
        ),
      );
    });
  }
}
