import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practice/Screnns/headlines.dart';
import 'package:practice/api_key.dart';

import '../Modals/news_source.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late StreamController _streamController;
  late Stream stream;
  String token = apiKey;

  getProfileApi() async {
    try {
      _streamController.add('loading');
      String url =
          'https://api.newscatcherapi.com/v2/sources?lang=en,ur&countries=PK';
      var response =
      await http.get(Uri.parse(url), headers: {'X-API-KEY': token});
      if (response.statusCode == 200) {
        var dataJson = json.decode(response.body);
        NewsSourceModel getProfileModel = NewsSourceModel.fromJson(dataJson);
        _streamController.add(getProfileModel);
      } else {
        _streamController.add('No data');
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('====================================> $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _streamController = StreamController();
    stream = _streamController.stream.asBroadcastStream();
    getProfileApi();
    if (kDebugMode) {
      print('ok');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NEWS SOURCE'),
        centerTitle: true,
        toolbarHeight: 80,
      ),
      body: StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == 'loading') {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              NewsSourceModel model = snapshot.data as NewsSourceModel;
              return ListView.builder(
                  itemCount: model.sources.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HeadlinesScreen(
                                  tag: model.sources[index],
                                )));
                      },
                      leading: Text('${index + 1}'),
                      title: Text(model.sources[index]),
                    );
                  });
            }
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}
