import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../easy_use_camera.dart';

Future<XFile?> takeFaceVideoOnDialog(BuildContext context, {Widget? scanWidget,CameraLensDirection? direction,ResolutionPreset? resolutionPreset,bool changeCamera = true}){
  return showDialog<XFile>(context: context, builder: (BuildContext context){
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
      child: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Camera(
          cameraDirection: direction,
          resolutionPreset: resolutionPreset,
          filterBuilder: (context, controller) {
            return Stack(
              children: [
                ScanFace(
                  changeCamera: changeCamera,
                  type: ScanFaceType.record,
                  onRecordStop: () async {
                    final result = await controller.stopVideoRecording();
                    if (context.mounted) {
                       Navigator.of(context).pop(result);
                    }
                  },
                  backTap: (){
                    Navigator.pop(context);
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

Future<XFile?> takeFacePictureOnDialog(BuildContext context,{Widget? scanWidget,CameraLensDirection? direction,ResolutionPreset? resolutionPreset,bool changeCamera = true}){
  return showDialog<XFile>(context: context, builder: (BuildContext context){
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
      child: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Camera(
          cameraDirection: direction,
          resolutionPreset: resolutionPreset,
          filterBuilder: (context, controller) {
            return Stack(
              children: [
                ScanFace(
                  changeCamera: changeCamera,
                  onCapture: () async {
                    final result = await controller.takePicture();
                    if (context.mounted) {
                      Navigator.of(context).pop(result);
                    }
                  },
                  backTap: (){
                    Navigator.pop(context);
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

Future<XFile?> takeCardPictureOnDialog(BuildContext context,{Widget? scanWidget,CameraLensDirection? direction,ResolutionPreset? resolutionPreset,bool changeCamera = true}){
  return showDialog<XFile>(context: context, builder: (BuildContext context){
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
      child: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Camera(
          cameraDirection: direction,
          resolutionPreset: resolutionPreset,
          filterBuilder: (context, controller) {
            return Stack(
              children: [
                ScanCard(
                  changeCamera: changeCamera,
                  onCapture: () async {
                    final result = await controller.takePicture();
                    if (context.mounted) {
                      Navigator.of(context).pop(result);
                    }
                  },
                  backTap: (){
                    Navigator.pop(context);
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

Future<XFile?> takeDocumentPictureOnDialog(BuildContext context,{Widget? scanWidget,CameraLensDirection? direction,ResolutionPreset? resolutionPreset,bool changeCamera = true}){
  return showDialog<XFile>(context: context, builder: (BuildContext context){
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
      child: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Camera(
          cameraDirection: direction,
          resolutionPreset: resolutionPreset,
          filterBuilder: (context, controller) {
            return Stack(
              children: [
                ScanDocument(
                  changeCamera: changeCamera,
                  onCapture: () async {
                    final result = await controller.takePicture();
                    if (context.mounted) {
                      Navigator.of(context).pop(result);
                    }
                  },
                  backTap: (){
                    Navigator.pop(context);
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