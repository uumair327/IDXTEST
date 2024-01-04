import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainHome(),
    );
  }
}

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  List<String> items = [
    "Outstation Trip",
    "Local Trip",
    "Airport Transfer",
  ];

  List<IconData> icons = [
    Icons.home,
    Icons.explore,
    Icons.search,
  ];
  int current = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          children: [
            Text(
              "Custom TabBar in Flutter",
              style: GoogleFonts.ubuntu(
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/herosection.jpg", // Adjust the image path as needed
              width: double.infinity,
              height: 200, // Adjust the height of the hero section
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: double.infinity,
              height: 80,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: items.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        current = index;
                      });
                      pageController.animateToPage(
                        current,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.ease,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: current == index
                              ? Colors.green
                              : Colors.transparent,
                          width: 2.5,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            icons[index],
                            size: 30,
                            color:
                                current == index ? Colors.green : Colors.black,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            items[index],
                            style: GoogleFonts.ubuntu(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                              color: current == index
                                  ? Colors.green
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 370,
              child: PageView.builder(
                itemCount: items.length,
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return getTabContent(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTabContent(int index) {
    switch (index) {
      case 0:
        return OutstationTab();
      case 1:
        return LocalTab();
      case 2:
        return AirportTransferTab();
      default:
        return Container();
    }
  }
}

class OutstationTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TabBar(
            indicator: const SizedBox.shrink(),
            labelColor: Colors.green,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: 'One Way',
              ),
              Tab(
                icon: Icon(Icons.home),
                text: 'Round Trip',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                // Content for One Way Trip
                ListView(
                  children: [
                    buildRow('Pick Up City'),
                    buildRow('Destination'),
                    buildRow('Pick Up Date'),
                    buildRow('Time'),
                  ],
                ),
                // Content for Round Trip
                ListView(
                  children: [
                    buildRow('Pick Up City'),
                    buildRow('Destination'),
                    buildRow('Time'),
                    buildRow('From Date, To Date'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRow(String labelText) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            labelText,
            style: TextStyle(fontSize: 18),
          ),
          // Add your input widgets here (TextFormField, DatePicker, etc.)
        ],
      ),
    );
  }
}

class LocalTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TabBar(
            indicator: const SizedBox.shrink(),
            labelColor: Colors.green,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(
                icon: Icon(Icons.explore),
                text: '8 hrs | 80 kms',
              ),
              Tab(
                icon: Icon(Icons.explore),
                text: '12 hr | 120 kms',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                // Content for 8 hrs | 80 kms
                ListView(
                  children: [
                    buildRow('Pick Up City'),
                    buildRow('Pick Up Date'),
                    buildRow('Time'),
                  ],
                ),
                // Content for 12 hr | 120 kms
                ListView(
                  children: [
                    buildRow('Pick Up City'),
                    buildRow('Pick Up Date'),
                    buildRow('Time'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRow(String labelText) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            labelText,
            style: TextStyle(fontSize: 18),
          ),
          // Add your input widgets here (TextFormField, DatePicker, etc.)
        ],
      ),
    );
  }
}

class AirportTransferTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TabBar(
            indicator: const SizedBox.shrink(),
            labelColor: Colors.green,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(
                icon: Icon(Icons.search),
                text: 'From Airport',
              ),
              Tab(
                icon: Icon(Icons.search),
                text: 'To Airport',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                // Content for From Airport
                ListView(
                  children: [
                    buildRow('Pick Up City'),
                    buildRow('Drop Address'),
                    buildRow('Pick Up Date'),
                    buildRow('Time'),
                  ],
                ),
                // Content for To Airport
                ListView(
                  children: [
                    buildRow('Pick Up City'),
                    buildRow('Drop Address'),
                    buildRow('Pick Up Date'),
                    buildRow('Time'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRow(String labelText) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            labelText,
            style: TextStyle(fontSize: 18),
          ),
          // Add your input widgets here (TextFormField, DatePicker, etc.)
        ],
      ),
    );
  }
}
