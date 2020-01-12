import 'dart:convert';

import 'package:eodiro/package/eodiro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  final url = 'https://api.eodiro.com/v2/campuses/seoul/vacant/buildings';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  Future<List> buildings;

  Future<List> fetchData() async {
    var response = await http.get(widget.url);
    Map<String, dynamic> data = jsonDecode(response.body);

    return data['buildings'];
  }

  @override
  void initState() {
    super.initState();
    buildings = fetchData();
    print('init home screen state');
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    print('home screen build method called');

    return Scrollbar(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 40,
                bottom: 20,
              ),
              child: Text(
                '빈 강의실',
                style: EodiroTextStyles.screenTitle,
              ),
            ),
            FutureBuilder(
              future: buildings,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      for (var building in snapshot.data)
                        Container(
                          color: EodiroColors.baseWhiteBlue,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  EodiroText(building['number'],
                                      style: EodiroTextStyles.defaultStyle),
                                  EodiroText(building['name']),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  EodiroText(building['empty'].toString()),
                                  EodiroText(building['total'].toString()),
                                ],
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
