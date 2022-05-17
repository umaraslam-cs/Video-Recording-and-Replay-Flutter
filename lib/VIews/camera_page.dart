import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/camera_controller.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final appCameraController = Get.put(AppCameraController());

  @override
  void initState() {
    super.initState();
    appCameraController.initCamera();
  }

  @override
  void dispose() {
    appCameraController.cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppCameraController>(builder: (controller) {
      return Scaffold(
        body: appCameraController.isLoading
            ? Container(
                color: Colors.white,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Center(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CameraPreview(appCameraController.cameraController),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: FloatingActionButton(
                        backgroundColor: Colors.red,
                        child: Icon(appCameraController.isRecording
                            ? Icons.stop
                            : Icons.circle),
                        onPressed: () => appCameraController.recordVideo(),
                      ),
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
