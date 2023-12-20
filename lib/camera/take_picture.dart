import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Camera extends StatelessWidget {
  const Camera({super.key, required this.filterBuilder, this.cameraDirection, this.resolutionPreset = ResolutionPreset.medium});

  final CameraLensDirection? cameraDirection;
  final ResolutionPreset? resolutionPreset;
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
                resolutionPreset: resolutionPreset,
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
  const TakePicture({super.key, required this.cameras, required this.filterBuilder, this.cameraDirection, required this.resolutionPreset, this.enableAudio});

  final Widget Function(BuildContext context, CameraController cameraController) filterBuilder;

  final List<CameraDescription> cameras;
  final CameraLensDirection? cameraDirection;
  final ResolutionPreset? resolutionPreset;
  final bool? enableAudio;

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
    if (widget.cameraDirection == null) {
      _cameraIndex = 0;
    } else {
      if(widget.cameras.any((camera) => camera.lensDirection == widget.cameraDirection && camera.sensorOrientation == 90)){
        _cameraIndex = widget.cameras.indexOf(widget.cameras.firstWhere((element) => element.lensDirection == widget.cameraDirection && element.sensorOrientation == 90));
      }else{
        final result = widget.cameras.where((element) => element.lensDirection == widget.cameraDirection).toList();
        if(result.isEmpty){
          _cameraIndex = 0;
        }else{
          _cameraIndex = widget.cameras.indexOf(result.first);
        }
      }
    }
    _currentCamera = widget.cameras[_cameraIndex];
    _controller = CameraController(
      _currentCamera,
      ResolutionPreset.medium,
      enableAudio: widget.enableAudio ?? true,
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
    return LayoutBuilder(
      builder: (context,constraints) {
        return FutureBuilder(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  if(kIsWeb)
                  Center(child: AspectRatio(aspectRatio:MediaQuery.of(context).size.aspectRatio,child: CameraPreview(_controller)))
                  else
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
    );
  }
}
