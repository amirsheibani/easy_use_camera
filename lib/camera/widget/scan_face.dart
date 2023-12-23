import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_use_camera/camera/widget/flash_widget.dart';
import 'package:easy_use_camera/camera/widget/zoom_widget.dart';

import 'back_widget.dart';

enum ScanFaceType { record, capture }

class ScanFace extends StatelessWidget {
  const ScanFace({super.key, this.onCapture, required this.onChangeCamera, required this.onFlash, required this.onZoom, this.zoomLevel, this.onRecord, this.type = ScanFaceType.capture, this.onRecordStop, this.backTap, this.changeCamera = true});

  final ScanFaceType type;
  final VoidCallback? onCapture;
  final VoidCallback? onRecord;
  final VoidCallback? onRecordStop;
  final VoidCallback onChangeCamera;
  final ValueChanged<FlashMode> onFlash;
  final ValueChanged<double> onZoom;
  final VoidCallback? backTap;
  final double? zoomLevel;
  final bool changeCamera;

  @override
  Widget build(BuildContext context) {
    const String svg = """
    <svg clip-rule="evenodd" fill-rule="evenodd" stroke-miterlimit="10" viewBox="0 0 139 139"
     xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
    <g clip-path="url(#a)">
        <path d="m110.962 55.705c0-.023-.007-.043-.007-.066 0-.043.007-.079.01-.119.066-2.805-3.204-4.072-5.307-3.125-.003-.251-.009-.512-.016-.786-.002-.072-.002-.145-.007-.217v-.037c-.029-.99-.091-2.214-.178-3.587-.211-3.406-.511-7.03-.596-8.469-.117-1.904-.434-3.755-.697-5.623-.108-.898-.214-1.7-.317-2.334-.09-.59-.207-1.181-.34-1.772-.03-.122-.062-.241-.093-.363-.207-.878-.454-1.752-.749-2.617-.006-.015-.013-.03-.016-.046-.621-1.807-1.418-3.571-2.367-5.257-.062-.113-.122-.228-.183-.34-.403-.692-.833-1.367-1.281-2.028-.168-.25-.334-.495-.509-.741-.38-.528-.775-1.045-1.188-1.548-.286-.357-.581-.703-.884-1.045-.155-.176-.317-.343-.476-.515-.553-.599-1.121-1.171-1.712-1.714-.231-.215-.473-.419-.713-.625-.277-.24-.544-.505-.831-.731-.172-.137-.36-.248-.538-.38-.562-.427-1.129-.838-1.721-1.216-.748-.484-1.523-.921-2.312-1.337-.096-.049-.185-.109-.277-.156-5.284-2.707-11.32-3.935-17.228-4.038-.344 0-.687.018-1.029.023-.344-.005-.688-.023-1.031-.023-5.907.103-11.94 1.331-17.224 4.036-.096.051-.187.112-.286.163-.786.413-1.559.852-2.307 1.332-.589.378-1.159.789-1.72 1.216-.174.132-.364.243-.538.38-.288.226-.552.491-.831.731-.238.206-.479.41-.711.625-.59.543-1.16 1.115-1.712 1.714-.159.172-.323.339-.478.515-.301.342-.599.688-.885 1.045-.409.503-.805 1.02-1.185 1.548-.174.246-.344.491-.511.741-.45.661-.878 1.336-1.277 2.028-.066.112-.126.227-.185.34-.95 1.686-1.749 3.45-2.366 5.257-.007.016-.013.031-.02.046-.29.865-.538 1.739-.749 2.617-.03.122-.06.241-.089.363-.132.591-.251 1.182-.344 1.772-.098.634-.204 1.436-.316 2.334-.264 1.868-.581 3.719-.693 5.623-.086 1.439-.39 5.063-.599 8.469-.088 1.373-.151 2.597-.178 3.587 0 .01 0 .023-.002.037 0 .072-.004.145-.007.217-.008.274-.013.535-.013.786-2.103-.947-5.373.32-5.307 3.125 0 .04.007.076.007.119 0 .023-.007.043-.007.066.002.046.02.211.05.446.122 2.155.563 4.286 1.069 6.389.04.178.079.35.119.511.551 2.31 1.062 4.644 1.87 6.881.661 1.825 1.587 6.201 4.096 6.106.044 0 .086-.004.125-.007.219-.023.447-.066.687-.158.02-.007.034-.007.049-.013.242.877.509 1.752.786 2.626.01.033.024.067.033.1.215.666.439 1.333.676 2 .206.577.42 1.148.638 1.722.003.013.01.023.013.036 1.353 3.548 3.01 7.02 4.926 10.261l.005.003v.004c.709 1.198 1.444 2.376 2.223 3.501 3.833 5.531 9 7.99 15.488 10.086.206.066.417.105.625.165.459.138.916.261 1.383.373.412.099.828.191 1.244.27.472.093.944.172 1.421.238.43.059.856.112 1.285.152.469.046.934.079 1.406.099.448.023.898.033 1.347.033.452 0 .9-.01 1.349-.033.469-.02.934-.053 1.403-.099.431-.04.858-.093 1.287-.152.475-.066.947-.145 1.418-.238.42-.079.832-.171 1.249-.27.465-.112.924-.235 1.383-.373.204-.06.415-.099.62-.165 6.491-2.096 11.659-4.555 15.49-10.086.779-1.125 1.513-2.303 2.222-3.501 0 0 .004 0 .004-.004v-.003c1.921-3.241 3.573-6.713 4.93-10.261.004-.013.006-.023.013-.036.218-.574.433-1.145.634-1.722.238-.667.462-1.334.68-2 .01-.033.02-.067.029-.1.28-.874.549-1.749.786-2.626.017.006.032.006.049.013.245.092.468.135.687.158.043.003.082.007.125.007 2.512.095 3.435-4.281 4.099-6.106.808-2.237 1.32-4.571 1.872-6.881.038-.161.075-.333.114-.511.508-2.103.947-4.234 1.073-6.389.03-.235.046-.4.046-.446z"
              fill="none" stroke="#FFEB3B" stroke-width="2"/>
    </g>
    </svg>
    """;

    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
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
                    const SizedBox(
                      width: 16,
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
        Expanded(
          child: LayoutBuilder(builder: (context, constraints) {
            return Center(
                child: SvgPicture.string(
              svg,
              fit: BoxFit.contain,
              width: double.maxFinite,
              height: double.maxFinite,
            ));
          }),
        ),
        Container(
          height: 100,
          width: double.maxFinite,
          color: Colors.transparent,
          child: Row(
            children: [
              const Spacer(),
              Expanded(
                child: InkWell(
                  onTap: type == ScanFaceType.capture ? onCapture : onRecord,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: type == ScanFaceType.capture
                        ? CaptureButton(
                            onCapture: onCapture,
                          )
                        : RecordButton(
                            onRecord: onRecord,
                            onRecordStop: onRecordStop,
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

class CaptureButton extends StatelessWidget {
  const CaptureButton({super.key, required this.onCapture});

  final VoidCallback? onCapture;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCapture,
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
    );
  }
}

class RecordButton extends StatefulWidget {
  const RecordButton({super.key, required this.onRecord, required this.onRecordStop});

  final VoidCallback? onRecord;
  final VoidCallback? onRecordStop;

  @override
  State<RecordButton> createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> {
  bool status = true;
  Timer? _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_start != 1 && !status)
          Container(
              width: 100,
              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), color: Colors.black38),
              child: Center(
                child: Text(
                  _printDuration(Duration(seconds: _start)),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white),
                ),
              )),
        const SizedBox(
          height: 8,
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              setState(() {
                status = !status;
                if (status) {
                  widget.onRecordStop?.call();
                } else {
                  widget.onRecord?.call();
                  startTimer();
                }
              });
            },
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
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: status ? Colors.white : Colors.red,
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
      ],
    );
  }
}
