import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_use_camera/easy_use_camera.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    File? recordResult;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              final result = await takeFaceVideoOnDialog(
                context,
                scanWidget: const Center(
                  child: Text('PLS '),
                ),
              );
              if (context.mounted && result != null) {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PreviewVideo(
                      file: result,
                      topFaceBuilder: (context){
                        return Center(
                          child: Text("Hello"),
                        );
                      },
                    ),
                  ),
                );
              }
            },
            child: const Text('take video'),
          ),
          ElevatedButton(
            onPressed: () async {
              final result = await takeFacePictureOnDialog(context);
              recordResult = File(result!.path);
            },
            child: const Text('take picture'),
          ),
          ElevatedButton(
            onPressed: () async {
              final result = await takeCardPictureOnDialog(context);
              recordResult = File(result!.path);
            },
            child: const Text('take card picture'),
          ),
          ElevatedButton(
            onPressed: () async {
              final result = await takeDocumentPictureOnDialog(context);
              recordResult = File(result!.path);
            },
            child: const Text('take document picture'),
          ),
        ],
      ),
    );
  }
}
