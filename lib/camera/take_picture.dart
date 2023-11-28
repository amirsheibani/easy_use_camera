import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Camera extends StatelessWidget {
  const Camera({super.key, required this.filterBuilder, this.cameraDirection});

  final CameraLensDirection? cameraDirection;
  final Widget Function(BuildContext context, CameraController cameraController) filterBuilder;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: FutureBuilder(
        future: availableCameras(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            if (snapShot.data != null && snapShot.data!.isNotEmpty) {
              return TakePicture(
                cameras: snapShot.data!,
                filterBuilder: filterBuilder,
                cameraDirection: cameraDirection,
              );
            } else {
              return Container(
                color: Colors.black,
                width: double.maxFinite,
                height: double.maxFinite,
                child: Center(
                  child: Text(
                    "This device is not support camera",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                ),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class TakePicture extends StatefulWidget {
  const TakePicture({super.key, required this.cameras, required this.filterBuilder, this.cameraDirection});

  final Widget Function(BuildContext context, CameraController cameraController) filterBuilder;

  final List<CameraDescription> cameras;
  final CameraLensDirection? cameraDirection;

  @override
  State<TakePicture> createState() => TakePictureState();
}

class TakePictureState extends State<TakePicture> {
  late CameraController _controller;
  late Future<void>? _initializeControllerFuture;
  late int _cameraIndex;
  late CameraDescription _currentCamera;

  @override
  void initState() {
    if(widget.cameraDirection == null){
      _cameraIndex = 0;
    }else{
      _cameraIndex = widget.cameras.indexWhere((element) => element.lensDirection == widget.cameraDirection);
    }
    _currentCamera = widget.cameras[_cameraIndex];
    _controller = CameraController(
      _currentCamera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void changeCamera() {
    setState(() {
      if (_cameraIndex < (widget.cameras.length - 1)) {
        _cameraIndex++;
      } else {
        _cameraIndex = 0;
      }
      _currentCamera = widget.cameras[_cameraIndex];
      _controller = CameraController(
        _currentCamera,
        ResolutionPreset.medium,
      );
      _initializeControllerFuture = _controller.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            children: [
              Center(child: CameraPreview(_controller)),
              widget.filterBuilder(context, _controller),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class PicturePreview extends StatelessWidget {
  const PicturePreview({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return (kIsWeb) ? Image.network(imagePath) : Image.file(File(imagePath));
  }
}
