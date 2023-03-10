import 'package:flutter/material.dart';
import 'package:practice/Screnns/tab_one.dart';

class TabbarPractice extends StatefulWidget {
  const TabbarPractice({Key? key}) : super(key: key);

  @override
  State<TabbarPractice> createState() => _TabbarPracticeState();
}

class _TabbarPracticeState extends State<TabbarPractice> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  'Rentals',
                  style: TextStyle(fontSize: 40),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  height: 45,
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0),
                      prefixIcon: const Icon(Icons.search_outlined),
                      hintText: 'Search for a rental',
                      fillColor: const Color(0xffE3E3E3),
                      filled: true,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xffE3E3E3)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xffE3E3E3)),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              SizedBox(
                height: 780,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color(0xffE3E3E3),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 6),
                        child: TabBar(
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 05),
                          indicatorColor: const Color(0xffE3E3E3),
                          tabs: [
                            Container(
                              width: 130,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                // color: const Color(0xffe9e9e9)),
                                color: Colors.white,
                              ),
                              child: const Center(
                                child: Text(
                                  'UpComing ()',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ),
                            ),
                            Container(
                              width: 130,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                // color: const Color(0xffe9e9e9)),
                                color: Colors.white,
                              ),
                              child: const Center(
                                child: Text(
                                  'InProgress ()',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                ),
                              ),
                            ),
                            Container(
                              width: 130,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                // color: const Color(0xffe9e9e9)),
                                color: Colors.white,
                              ),
                              child: const Center(
                                child: Text(
                                  'Ended',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Expanded(
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          TabbarOne(),
                          TabbarOne(),
                          TabbarOne(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
