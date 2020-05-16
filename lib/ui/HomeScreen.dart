import 'package:alquran/controllers/FetchSurahFromApiUseCase.dart';
import 'package:alquran/models/MetaInformation.dart';
import 'package:alquran/models/SurahListModel.dart';
import 'package:alquran/ui/NavDrawer.dart';
import 'package:alquran/ui/SurahDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _HomeScreenState(),
    );
  }
}

class _HomeScreenState extends StatefulWidget {
  @override
  __HomeScreenStateState createState() => __HomeScreenStateState();
}

class __HomeScreenStateState extends State<_HomeScreenState> {
  List<SingleSuraModel> _surahList;
  bool loading;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = true;
    _surahList = [];
    FetchApiDataUseCase().fetchSurahList().then((value) {
      setState(() {
        _surahList = value;
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Surah"),
      ),
      drawer: NavDrawer(),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("Bismillahir Rahmanir Rahim"),
                ],
              ),
              Visibility(
                visible: loading ?? true,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.redAccent,
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(height: 0.5),
                  itemCount: _surahList.length,
                  itemBuilder: (context, index) =>
                      _buildItem(context, _surahList[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, SingleSuraModel model) {
    return Card(
      elevation: 1.0,
      child: ListTile(
        leading: Text(model.number.toString(),
            style: TextStyle(color: Colors.white)),
        trailing: InkWell(
          child: Icon(
            Icons.favorite_border,
            color: Colors.redAccent,
          ),
          onTap: () {},
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[Text(model.englishName), Text(model.name)],
        ),
        subtitle: Text("Total verse ${model.number}"),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>
                  SurahDetailsScreen(surahId: model.number)));
        },
      ),
    );
  }

  Future<Null> refreshData() async {
    setState(() {
      loading = true;
    });
    var result = await FetchApiDataUseCase().fetchSurahList();
    setState(() {
      _surahList = result;
      loading = false;
    });
    return null;
  }
}
