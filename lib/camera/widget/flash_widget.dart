import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class FlashCameraWidget extends StatefulWidget {
  const FlashCameraWidget({super.key, required this.flashStatus, required this.onChangeFlash});
  final FlashMode? flashStatus;
  final ValueChanged<FlashMode> onChangeFlash;

  @override
  State<FlashCameraWidget> createState() => _FlashCameraWidgetState();
}

class _FlashCameraWidgetState extends State<FlashCameraWidget> {
  FlashMode _flashStatus = FlashMode.off;
  int _flashModeIndex = 0;

  @override
  void initState() {
    _flashStatus = widget.flashStatus ?? FlashMode.auto;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      setState(() {
        if(_flashModeIndex < 2){
          _flashModeIndex++;
        }else{
          _flashModeIndex = 0;
        }
        if(_flashModeIndex == 0){
          _flashStatus = FlashMode.off;
        }else if(_flashModeIndex == 1){
          _flashStatus = FlashMode.auto;
        }else{
          _flashStatus = FlashMode.torch;
        }
        widget.onChangeFlash(_flashStatus);
      });
    }, icon: Icon(_getFlashIcon(_flashStatus),color: Colors.white,size: 32,));
  }

  IconData _getFlashIcon(FlashMode flashStatus){
    switch(flashStatus){
      case FlashMode.off:
      return Icons.flash_off;
      case FlashMode.auto:
        return Icons.flash_auto;
      case FlashMode.always:
        return Icons.flash_on;
      case FlashMode.torch:
        return Icons.flash_on;
    }
  }
}
