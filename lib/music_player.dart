import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

enum AudioPlayerState { start, pause, stop }

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  var downloading = false;
  String? progress;
  var dio = Dio();
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();
  AudioPlayerState audioPlayerState = AudioPlayerState.stop;

  // int progress = 0;

  bool isPlaying = false;
  String audioPath = 'SatvamevJayate.mp3';
  String currentTime = "00:00";
  String completeTime = "00:00";
  // ReceivePort receivePort = ReceivePort();
  // downloadCallback(id, status, progress) {
  //   SendPort? sendPort = IsolateNameServer.lookupPortByName('download');
  //   sendPort?.send(progress);
  // }

  @override
  void initState() {
    super.initState();
    // IsolateNameServer.registerPortWithName(receivePort.sendPort, "download");
    // receivePort.listen((message) {
    //   setState(() {
    //     progress = message;
    //   });
    // });
    // FlutterDownloader.registerCallback(downloadCallback);

    audioCache = AudioCache(fixedPlayer: audioPlayer);

    audioPlayer.onAudioPositionChanged.listen((Duration duration) {
      setState(() {
        currentTime = duration.toString().split('.')[0];
      });
    });

    audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        completeTime = duration.toString().split('.')[0];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              IconButton(
                icon: audioPlayerState == AudioPlayerState.stop ||
                        audioPlayerState == AudioPlayerState.pause
                    ? const Icon(Icons.play_arrow)
                    : const Icon(Icons.pause),
                onPressed: () async {
                  // await audioCache.play('audio.mp3');

                  if (audioPlayerState == AudioPlayerState.stop) {
                    await audioCache.play(audioPath);
                    setState(() {
                      audioPlayerState = AudioPlayerState.start;
                    });
                  } else if (audioPlayerState == AudioPlayerState.start) {
                    audioPlayer.pause();
                    setState(() {
                      audioPlayerState = AudioPlayerState.pause;
                    });
                  } else {
                    audioPlayer.resume();
                    setState(() {
                      audioPlayerState = AudioPlayerState.start;
                    });
                  }
                },
              ),
              IconButton(
                onPressed: () async {
                  if (audioPlayerState == AudioPlayerState.pause) {
                    await audioPlayer.stop();
                    setState(() {
                      audioPlayerState = AudioPlayerState.stop;
                    });
                  } else {
                    await audioPlayer.stop();
                    setState(() {
                      audioPlayerState = AudioPlayerState.stop;
                    });
                  }
                },
                icon: const Icon(Icons.stop),
              ),
            ],
          ),
        ),
        // const SizedBox(
        //   width: 20,
        // ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Text(currentTime),
              const Text('  |  '),
              Text(completeTime),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () async {
                  String audDir = '';
                  print('i am in onpress');
                  // openFile(
                  //   url:
                  //       'https://cdn.sndup.net/yrjr/SatvamevJayate.mp3?token=NjszzIEXB24biaDa5V3FaPLgoKJZD7JADmU416LQr54&token_path=%2Fyrjr%2F&expires=1650543349',
                  //   fileName: 'satyameva.mp3',
                  // );

                  final status = await Permission.storage.request();
                  if (status.isGranted) {
                    if (Platform.isAndroid) {
                      print('Hi i have granted');
                      audDir = 'storage/emulated/0/Download/SatvaMevaJayate/';
                      final path = Directory(audDir);
                      if (await path.exists()) {
                      } else {
                        path.create();
                      }
                    }
                    print('Grant access');
                    final dir = await getExternalStorageDirectory();

                    await dio.download(
                      'https://drive.google.com/uc?export=download&id=1eBYcTzezSxCtCzBzl71-xBlVYBUJlIWU',
                      audDir + 'SatvamevaJayate.mp3',
                      onReceiveProgress: (count, total) {
                        print('Diwnload Started');
                        downloading = true;

                        progress =
                            ((count / total) * 100).toStringAsFixed(0) + "%";
                        print(progress);
                      },
                    );
                    Fluttertoast.showToast(
                        msg:
                            'Download Completed at /Download/SatvaMevaJayate/ ');

                    // await openFile(String url,String fileName!);
                    // final id = await FlutterDownloader.enqueue(
                    //     fileName: "Satvamev Jayate",
                    //     showNotification: true,
                    //     openFileFromNotification: true,
                    //     url:
                    //         'https://drive.google.com/uc?export=download&id=1eBYcTzezSxCtCzBzl71-xBlVYBUJlIWU',
                    //     savedDir: dir!.path);
                    // FlutterDownloader.registerCallback(); // callback is a top-level or static function
                  } else {
                    Fluttertoast.showToast(msg: "Permission denied");
                  }
                },
                icon: const Icon(Icons.download),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Future openFile({required String url, String? fileName}) async {
//   print('OpenFIle');
//   final file = await downloadFile(url, fileName!);
//   if (file == null) return;
//   print('Path: ${file.path}');
//   OpenFile.open(file.path);
// }

// Future<File?> downloadFile(String url, String name) async {
//   print('DownloadFIle');
//   final appStorage = await getApplicationDocumentsDirectory();
//   final file = File('${appStorage.path}/$name');

//   try {
//     print('In try');
//     final response = await Dio().get(
//       url,
//       options: Options(
//         responseType: ResponseType.bytes,
//         followRedirects: false,
//         receiveTimeout: 0,
//       ),
//     );
//     final rar = file.openSync(mode: FileMode.write);
//     rar.writeFromSync(response.data);
//     await rar.close();
//     return file;
//   } catch (e) {
//     return null;
//   }
// }
