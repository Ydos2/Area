import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'player_widget.dart';

typedef OnError = void Function(Exception exception);

const kUrl1 = 'https://luan.xyz/files/audio/ambient_c_motion.mp3';
const kUrl2 = 'https://luan.xyz/files/audio/nasa_on_a_mission.mp3';
const kUrl3 = 'http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio1xtra_mf_p';

class ExampleApp extends StatefulWidget {
  @override
  _ExampleAppState createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  String? localFilePath;
  String? localAudioCacheURI;

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      // Calls to Platform.isIOS fails on web
      return;
    }
    if (Platform.isIOS) {
      audioCache.fixedPlayer?.notificationService.startHeadlessService();
    }
  }

  Future _loadFile() async {
    final bytes = await readBytes(Uri.parse(kUrl1));
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/audio.mp3');

    await file.writeAsBytes(bytes);
    if (file.existsSync()) {
      setState(() => localFilePath = file.path);
    }
  }

  Widget remoteUrl() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Text(
            'Sample 1 ($kUrl1)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          PlayerWidget(url: kUrl1),
          Text(
            'Sample 2 ($kUrl2)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          PlayerWidget(url: kUrl2),
          Text(
            'Sample 3 ($kUrl3)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          PlayerWidget(url: kUrl3),
          Text(
            'Sample 4 (Low Latency mode) ($kUrl1)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          PlayerWidget(url: kUrl1, mode: PlayerMode.LOW_LATENCY),
          /*TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              //_loadFileAC();
              audioCache.play(kUrl2);
            },
            child: const Text('Play'),
          ),*/
        ],
      ),
    );
  }

  void _loadFileAC() async {
    final uri = await audioCache.load(kUrl2);
    setState(() => localAudioCacheURI = uri.toString());
  }

  Widget localAsset() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text("Play Local Asset 'audio.mp3':"),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () => audioCache.play('audio.mp3'),
            child: const Text('Play'),
          ),
          const Text("Play Local Asset (via byte source) 'audio.mp3':"),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () async {
              final file = await audioCache.loadAsFile('audio.mp3');
              final bytes = await file.readAsBytes();
              audioCache.playBytes(bytes);
            },
            child: const Text('Play'),
          ),
          const Text("Loop Local Asset 'audio.mp3':"),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () async {
              audioCache.loop('audio.mp3');
            },
            child: const Text('Play'),
          ),
          const Text("Loop Local Asset (via byte source) 'audio.mp3':"),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () async {
              final file = await audioCache.loadAsFile('audio.mp3');
              final bytes = await file.readAsBytes();
              audioCache.playBytes(bytes, loop: true);
            },
            child: const Text('Loop'),
          ),
          getLocalFileDuration(),
        ],
      ),
    );
  }

  Future<int> _getDuration() async {
    final uri = await audioCache.load('audio2.mp3');
    await advancedPlayer.setUrl(uri.toString());
    return Future.delayed(
      const Duration(seconds: 2),
      () => advancedPlayer.getDuration(),
    );
  }

  FutureBuilder<int> getLocalFileDuration() {
    return FutureBuilder<int>(
      future: _getDuration(),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Text('No Connection...');
          case ConnectionState.active:
          case ConnectionState.waiting:
            return const Text('Awaiting result...');
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return Text(
              'audio2.mp3 duration is: ${Duration(milliseconds: snapshot.data!)}',
            );
        }
      },
    );
  }

  Widget notification() {
    return Column(
      children: [
        const Text("Play notification sound: 'messenger.mp3':"),
        /*Btn(
          txt: 'Play',
          onPressed: () =>
              audioCache.play('messenger.mp3', isNotification: true),
        ),*/
        const Text('Notification Service'),
        ElevatedButton(
          child: Text('Notification'),
          onPressed: () async {
            await advancedPlayer.notificationService.startHeadlessService();
            await advancedPlayer.notificationService.dispose();
            await advancedPlayer.notificationService.setNotification(
              title: 'My Song',
              albumTitle: 'My Album',
              artist: 'My Artist',
              imageUrl: 'Image URL or blank',
              forwardSkipInterval: const Duration(seconds: 30),
              backwardSkipInterval: const Duration(seconds: 30),
              duration: const Duration(minutes: 3),
              elapsedTime: const Duration(seconds: 15),
              enableNextTrackButton: true,
              enablePreviousTrackButton: true,
            );

            await advancedPlayer.play(
              kUrl2,
              isLocal: false,
            );
          },
        ),
        ElevatedButton(
          child: Text('Clear Notification'),
          onPressed: () async {
            await advancedPlayer.stop();
            await advancedPlayer.notificationService.clearNotification();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<Duration>.value(
          initialData: const Duration(),
          value: advancedPlayer.onAudioPositionChanged,
        ),
      ],
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Remote Url'),
                Tab(text: 'Local File'),
                Tab(text: 'Notification'),
                /*Tab(text: 'Local Asset'),
                Tab(text: 'Advanced'),
                Tab(text: 'Global Config'),*/
              ],
            ),
            title: const Text('audioplayers Example'),
          ),
          body: TabBarView(
            children: [
              remoteUrl(),
              localAsset(),
              notification(),
              //Advanced(advancedPlayer: advancedPlayer),
              //const GlobalTab(),
            ],
          ),
        ),
      ),
    );
  }
}
/*
class Advanced extends StatefulWidget {
  final AudioPlayer advancedPlayer;

  const Advanced({Key? key, required this.advancedPlayer}) : super(key: key);

  @override
  _AdvancedState createState() => _AdvancedState();
}*/
/*
class _AdvancedState extends State<Advanced> {
  bool? seekDone;

  @override
  void initState() {
    widget.advancedPlayer.onSeekComplete
        .listen((event) => setState(() => seekDone = true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final audioPosition = Provider.of<Duration>(context);
    return SingleChildScrollView(
      child: TabWrapper(
        children: [
          Column(
            children: [
              const Text('Source Url'),
              Row(
                children: [
                  Btn(
                    txt: 'Audio 1',
                    onPressed: () => widget.advancedPlayer.setUrl(kUrl1),
                  ),
                  Btn(
                    txt: 'Audio 2',
                    onPressed: () => widget.advancedPlayer.setUrl(kUrl2),
                  ),
                  Btn(
                    txt: 'Stream',
                    onPressed: () => widget.advancedPlayer.setUrl(kUrl3),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
            ],
          ),
          Column(
            children: [
              const Text('Release Mode'),
              Row(
                children: [
                  Btn(
                    txt: 'STOP',
                    onPressed: () =>
                        widget.advancedPlayer.setReleaseMode(ReleaseMode.STOP),
                  ),
                  Btn(
                    txt: 'LOOP',
                    onPressed: () =>
                        widget.advancedPlayer.setReleaseMode(ReleaseMode.LOOP),
                  ),
                  Btn(
                    txt: 'RELEASE',
                    onPressed: () => widget.advancedPlayer
                        .setReleaseMode(ReleaseMode.RELEASE),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
            ],
          ),
          Column(
            children: [
              const Text('Volume'),
              Row(
                children: [0.0, 0.3, 0.5, 1.0, 1.1, 2.0].map((e) {
                  return Btn(
                    txt: e.toString(),
                    onPressed: () => widget.advancedPlayer.setVolume(e),
                  );
                }).toList(),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
            ],
          ),
          Column(
            children: [
              const Text('Control'),
              Row(
                children: [
                  Btn(
                    txt: 'resume',
                    onPressed: () => widget.advancedPlayer.resume(),
                  ),
                  Btn(
                    txt: 'pause',
                    onPressed: () => widget.advancedPlayer.pause(),
                  ),
                  Btn(
                    txt: 'stop',
                    onPressed: () => widget.advancedPlayer.stop(),
                  ),
                  Btn(
                    txt: 'release',
                    onPressed: () => widget.advancedPlayer.release(),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
            ],
          ),
          Column(
            children: [
              const Text('Seek in milliseconds'),
              Row(
                children: [
                  Btn(
                    txt: '100ms',
                    onPressed: () {
                      widget.advancedPlayer.seek(
                        Duration(
                          milliseconds: audioPosition.inMilliseconds + 100,
                        ),
                      );
                      setState(() => seekDone = false);
                    },
                  ),
                  Btn(
                    txt: '500ms',
                    onPressed: () {
                      widget.advancedPlayer.seek(
                        Duration(
                          milliseconds: audioPosition.inMilliseconds + 500,
                        ),
                      );
                      setState(() => seekDone = false);
                    },
                  ),
                  Btn(
                    txt: '1s',
                    onPressed: () {
                      widget.advancedPlayer.seek(
                        Duration(seconds: audioPosition.inSeconds + 1),
                      );
                      setState(() => seekDone = false);
                    },
                  ),
                  Btn(
                    txt: '1.5s',
                    onPressed: () {
                      widget.advancedPlayer.seek(
                        Duration(
                          milliseconds: audioPosition.inMilliseconds + 1500,
                        ),
                      );
                      setState(() => seekDone = false);
                    },
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
            ],
          ),
          Column(
            children: [
              const Text('Rate'),
              Row(
                children: [0.5, 1.0, 1.5, 2.0, 5.0].map((e) {
                  return Btn(
                    txt: e.toString(),
                    onPressed: () {
                      widget.advancedPlayer.setPlaybackRate(e);
                    },
                  );
                }).toList(),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
            ],
          ),
          Text('Audio Position: $audioPosition'),
          if (seekDone != null) Text(seekDone! ? 'Seek Done' : 'Seeking...'),
        ],
      ),
    );
  }
}
*/