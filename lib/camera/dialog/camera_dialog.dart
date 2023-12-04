import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../easy_use_camera.dart';

Future<XFile?> takeFaceVideoOnDialog(BuildContext context, {Widget? scanWidget}){
  return showDialog<XFile>(context: context, builder: (BuildContext context){
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
      child: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Camera(
          cameraDirection: CameraLensDirection.front,
          filterBuilder: (context, controller) {
            return Stack(
              children: [
                ScanFace(
                  type: ScanFaceType.record,
                  onRecordStop: () async {
                    final result = await controller.stopVideoRecording();
                    if (context.mounted) {
                       Navigator.of(context).pop(result);
                    }
                  },
                  onRecord: () async {
                    await controller.startVideoRecording();
                  },
                  onChangeCamera: () {
                    final TakePictureState? state = context.findAncestorStateOfType<TakePictureState>();
                    if (state != null) {
                      state.changeCamera();
                    }
                  },
                  onFlash: (status) {
                    controller.setFlashMode(status);
                  },
                  onZoom: (zoomLevel) {
                    controller.setZoomLevel(zoomLevel);
                  },
                ),
                if(scanWidget != null)
                scanWidget,
              ],
            );
          },
        ),
      ),
    );
  });
}

Future<XFile?> takeFacePictureOnDialog(BuildContext context,{Widget? scanWidget}){
  return showDialog<XFile>(context: context, builder: (BuildContext context){
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
      child: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Camera(
          // cameraDirection: CameraLensDirection.front,
          filterBuilder: (context, controller) {
            return Stack(
              children: [
                ScanFace(
                  onCapture: () async {
                    final result = await controller.takePicture();
                    if (context.mounted) {
                      Navigator.of(context).pop(result);
                    }
                  },
                  onChangeCamera: () {
                    final TakePictureState? state = context.findAncestorStateOfType<TakePictureState>();
                    if (state != null) {
                      state.changeCamera();
                    }
                  },
                  onFlash: (status) {
                    controller.setFlashMode(status);
                  },
                  onZoom: (zoomLevel) {
                    controller.setZoomLevel(zoomLevel);
                  },
                ),
                if(scanWidget != null)
                  scanWidget,
              ],
            );
          },
        ),
      ),
    );
  });
}

Future<XFile?> takeCardPictureOnDialog(BuildContext context,{Widget? scanWidget}){
  return showDialog<XFile>(context: context, builder: (BuildContext context){
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
      child: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Camera(
          // cameraDirection: CameraLensDirection.back,
          filterBuilder: (context, controller) {
            return Stack(
              children: [
                ScanCard(
                  onCapture: () async {
                    final result = await controller.takePicture();
                    if (context.mounted) {
                      Navigator.of(context).pop(result);
                    }
                  },
                  onChangeCamera: () {
                    final TakePictureState? state = context.findAncestorStateOfType<TakePictureState>();
                    if (state != null) {
                      state.changeCamera();
                    }
                  },
                  onFlash: (status) {
                    controller.setFlashMode(status);
                  },
                  onZoom: (zoomLevel) {
                    controller.setZoomLevel(zoomLevel);
                  },
                ),
                if(scanWidget != null)
                  scanWidget,
              ],
            );
          },
        ),
      ),
    );
  });
}

Future<XFile?> takeDocumentPictureOnDialog(BuildContext context,{Widget? scanWidget}){
  return showDialog<XFile>(context: context, builder: (BuildContext context){
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
      child: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Camera(
          // cameraDirection: CameraLensDirection.back,
          filterBuilder: (context, controller) {
            return Stack(
              children: [
                ScanDocument(
                  onCapture: () async {
                    final result = await controller.takePicture();
                    if (context.mounted) {
                      Navigator.of(context).pop(result);
                    }
                  },
                  onChangeCamera: () {
                    final TakePictureState? state = context.findAncestorStateOfType<TakePictureState>();
                    if (state != null) {
                      state.changeCamera();
                    }
                  },
                  onFlash: (status) {
                    controller.setFlashMode(status);
                  },
                  onZoom: (zoomLevel) {
                    controller.setZoomLevel(zoomLevel);
                  },
                ),
                if(scanWidget != null)
                  scanWidget,
              ],
            );
          },
        ),
      ),
    );
  });
}