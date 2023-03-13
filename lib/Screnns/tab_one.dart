import 'dart:convert';

import 'package:flutter/material.dart';

import '../Modals/tabbar_model.dart';

class TabbarOne extends StatefulWidget {
  final String searchQuery;

  const TabbarOne({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<TabbarOne> createState() => _TabbarOneState();
}

class _TabbarOneState extends State<TabbarOne> {
  Future<List<TabbarModel>> getAllData(BuildContext context) async {
    var myData = <TabbarModel>[];
    var assetBundle = DefaultAssetBundle.of(context);
    var data = await assetBundle.loadString('assets/data.json');
    var jsonData = json.decode(data);
    var jsonSchedule = jsonData['data'];

    for (var jsonMatch in jsonSchedule) {
      TabbarModel match = TabbarModel.fromJSON(jsonMatch);
      myData.add(match);
      if (widget.searchQuery.isNotEmpty) {
        setState(() {
          myData = myData
              .where((item) =>
                  item.name.toLowerCase().contains(widget.searchQuery))
              .toList();
        });
      }
    }

    return myData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<TabbarModel>>(
        future: getAllData(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<TabbarModel> data = snapshot.data;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var myData = data[index];
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 12),
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(myData.image),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 10),
                        width: MediaQuery.of(context).size.width * 0.77,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              myData.name,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Text(myData.sDate),
                                const SizedBox(width: 8),
                                const Icon(Icons.arrow_forward),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(myData.eDate),
                                const Spacer(),
                                const Icon(Icons.arrow_forward_ios),
                                const SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(myData.carName),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      border:
                                          Border.all(color: Colors.black26)),
                                  child: Text(myData.lNumber),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 12),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffE3E3E3),
                                    borderRadius: BorderRadius.circular(2),
                                    border: Border.all(
                                      color: const Color(0xffE3E3E3),
                                    ),
                                  ),
                                  child: Text(
                                    myData.status,
                                    style:
                                        const TextStyle(color: Colors.black45),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              color: Colors.black45,
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
