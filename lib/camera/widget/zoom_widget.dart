import 'package:flutter/material.dart';

class ZoomCameraWidget extends StatefulWidget {
  const ZoomCameraWidget({super.key, required this.zoomInt, required this.onChangeZoom});
  final double zoomInt;
  final ValueChanged<double> onChangeZoom;

  @override
  State<ZoomCameraWidget> createState() => _ZoomCameraWidgetState();
}

class _ZoomCameraWidgetState extends State<ZoomCameraWidget> {
  double zoomLevel = 0.0;
  bool zoomLeveToggle = true;

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      setState(() {
        if(zoomLevel < 4.0){
          zoomLevel += 1 ;
        }else{
          zoomLevel = 0.0;
        }
        widget.onChangeZoom(zoomLevel);
      });
    }, icon: Icon(zoomLevel == 4.0 ? Icons.zoom_in_map_sharp : Icons.zoom_in,color: Colors.white,size: 32,));
  }
}
