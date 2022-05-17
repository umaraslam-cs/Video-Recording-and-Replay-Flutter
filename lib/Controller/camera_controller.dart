import 'dart:io';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../VIews/video_page.dart';

class AppCameraController extends GetxController {
  bool isLoading = true;
  bool isRecording = false;
  late CameraController cameraController;
  late VideoPlayerController videoPlayerController;

  initCamera() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);
    cameraController = CameraController(front, ResolutionPreset.max);
    await cameraController.initialize();
    isLoading = false;
    update();
  }

  recordVideo() async {
    if (isRecording) {
      final file = await cameraController.stopVideoRecording();
      isRecording = false;
      update();
      Get.to(() => VideoPage(filePath: file.path));
    } else {
      await cameraController.prepareForVideoRecording();
      await cameraController.startVideoRecording();
      isRecording = true;
      update();
    }
  }

  Future initVideoPlayer(path) async {
    videoPlayerController = VideoPlayerController.file(File(path));
    await videoPlayerController.initialize();
    await videoPlayerController.setLooping(true);
    await videoPlayerController.play();
  }
}
