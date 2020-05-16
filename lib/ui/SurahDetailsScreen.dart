import 'dart:io';

import 'package:alquran/Utils/Utility.dart';
import 'package:alquran/controllers/FetchSurahFromApiUseCase.dart';
import 'package:alquran/models/SurahDetailsModel.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SurahDetailsScreen extends StatelessWidget {
  final int surahId;

  const SurahDetailsScreen({Key key, this.surahId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _SurahDetailsScreen(surahId: surahId);
  }
}

class _SurahDetailsScreen extends StatefulWidget {
  final int surahId;

  const _SurahDetailsScreen({Key key, this.surahId}) : super(key: key);
  @override
  __SurahDetailsScreenState createState() => __SurahDetailsScreenState();
}

class __SurahDetailsScreenState extends State<_SurahDetailsScreen> {
  SingleSurahDetailsWithAyah details;
  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  String localFilePath;
  bool isPlaying = false;

  bool loading;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = true;
    FetchApiDataUseCase().fetchSurahDetails(widget.surahId).then((value) {
      setState(() {
        details = value;
        loading = false;
      });
    });
    if (Platform.isIOS) {
      if (audioCache.fixedPlayer != null) {
        audioCache.fixedPlayer.startHeadlessService();
      }
      advancedPlayer.startHeadlessService();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (advancedPlayer != null) {
      advancedPlayer.stop();
      advancedPlayer.release();
      advancedPlayer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(details == null ? "Details" : details.englishName)),
      body: RefreshIndicator(
        onRefresh: () {
          return _refreshDetails();
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Visibility(
                visible: loading ?? true,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.redAccent,
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return ListTile(
                          title: Text("Number of Ayah"),
                          trailing: Text(details == null
                              ? "?"
                              : details.numberOfAyahs.toString()),
                        );
                      }
                      return _buildeAyahRow(details.ayahs[index - 1]);
                    },
                    separatorBuilder: (context, index) => Divider(height: 0.5),
                    itemCount: details == null ? 0 : details.ayahs.length),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        child: Row(
          children: <Widget>[
            InkWell(
              child: Icon(Icons.play_arrow),
            )
          ],
        ),
        height: 50.0,
        color: Colors.redAccent,
      ),
    );
  }

  Widget _buildeAyahRow(Ayah ayah) {
    return ListTile(
      onTap: () {
        if (advancedPlayer != null) {
          if (isPlaying) {
            advancedPlayer.stop();
            advancedPlayer.release();
            isPlaying = false;
            return;
          }
          isPlaying = true;
          advancedPlayer.play(
              Utility().AUDIO_BASE_URL + ayah.number.toString() + "/high",
              isLocal: false,
              respectSilence: false);
        }
      },
      title: Text(
        ayah.text,
        textAlign: TextAlign.end,
        style: TextStyle(
          fontFamily: 'scheraz',
          fontSize: 30.0,
        ),
      ),
      subtitle: Text(
        "Ayah No : ${ayah.number.toString()}  Page : ${ayah.page.toString()}",
        textAlign: TextAlign.end,
      ),
    );
  }

  Future<Null> _refreshDetails() async {
    setState(() {
      loading = true;
    });
    var result = await FetchApiDataUseCase().fetchSurahDetails(widget.surahId);
    setState(() {
      details = result;
      loading = false;
    });
  }
}
