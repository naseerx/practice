import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Modals/headlines_model.dart';
import '../api_key.dart';

class HeadlinesScreen extends StatefulWidget {
  final String tag;
  const HeadlinesScreen({Key? key, required this.tag}) : super(key: key);

  @override
  State<HeadlinesScreen> createState() => _HeadlinesScreenState();
}

class _HeadlinesScreenState extends State<HeadlinesScreen> {
  late StreamController _streamController;
  late Stream stream;
  String token = apiKey;

  getProfileApi() async {
    String tag = widget.tag;
    try {
      _streamController.add('loading');
      String url =
          'https://api.newscatcherapi.com/v2/latest_headlines?countries=PK&sources=$tag';
      var response =
          await http.get(Uri.parse(url), headers: {'X-API-KEY': token});
      if (response.statusCode == 200) {
        var dataJson = json.decode(response.body);
        NewsHeadlinesModel getProfileModel =
            NewsHeadlinesModel.fromJson(dataJson);
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
  logout() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            backgroundColor: gPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Confirmation !',
                    style: TextStyle(color: gWhite),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                DelayedDisplay(
                  delay: Duration(microseconds: 400),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Are you sure to Quit the App',
                      style: TextStyle(color: gWhite),
                    ),
                  ),
                )
              ],
            ),
            // content: Text('We hate to see you leave...'),
            actions: [
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: DelayedDisplay(
                      delay: const Duration(milliseconds: 800),
                      slidingBeginOffset: const Offset(0.35, 0.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: gGreenButton,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'No',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: DelayedDisplay(
                      delay: const Duration(milliseconds: 1200),
                      slidingBeginOffset: const Offset(0.35, 0.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Yes',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Get.offAll(() => const HomeScreen(),
                              transition: Transition.downToUp,
                              duration: const Duration(seconds: 1));
                          Fluttertoast.showToast(
                              msg: 'Logout Successfully',
                              backgroundColor: gPrimaryColor,
                              textColor: gBlack);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );

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
              NewsHeadlinesModel model = snapshot.data as NewsHeadlinesModel;
              return ListView.builder(
                  itemCount: model.articles.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var data = model.articles[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          data.media
                        ),
                      ),
                      title: Text(data.title),
                      subtitle: Text(data.summary),
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
