import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_use_camera/camera/widget/flash_widget.dart';
import 'package:easy_use_camera/camera/widget/zoom_widget.dart';

import 'back_widget.dart';

class ScanDocument extends StatelessWidget {
  const ScanDocument({super.key, required this.onCapture, required this.onChangeCamera, required this.onFlash, required this.onZoom, this.zoomLevel, this.backTap,  this.changeCamera = true});

  final VoidCallback onCapture;
  final VoidCallback onChangeCamera;
  final ValueChanged<FlashMode> onFlash;
  final ValueChanged<double> onZoom;
  final VoidCallback? backTap;
  final double? zoomLevel;
  final bool changeCamera;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24,),
        Container(
          height: 48,
          width: double.maxFinite,
          color: Colors.transparent,
          child: kIsWeb
              ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 16,
              ),
              BackWidget(
                onTap: backTap,
              ),
              const Spacer(),
            ],
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 16,
              ),
              BackWidget(
                onTap: backTap,
              ),
              const Spacer(),
              FlashCameraWidget(
                flashStatus: FlashMode.off,
                onChangeFlash: onFlash,
              ),
              ZoomCameraWidget(
                zoomInt: zoomLevel ?? 0.0,
                onChangeZoom: onZoom,
              ),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
        ),
        const Spacer(),
        Container(
          height: 100,
          width: double.maxFinite,
          color: Colors.transparent,
          child: Row(
            children: [
              const Spacer(),
              Expanded(
                child: InkWell(
                  onTap: onCapture,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Container(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Center(
                            child: Container(
                              width: double.maxFinite,
                              height: double.maxFinite,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Center(
                                  child: Container(
                                    width: double.maxFinite,
                                    height: double.maxFinite,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if(changeCamera)
              Expanded(
                child: IconButton(onPressed: onChangeCamera, icon: const Icon(Icons.cameraswitch_outlined), color: Colors.white, iconSize: 32),
              )
              else
                const Spacer()
            ],
          ),
        ),
      ],
    );
  }
}
