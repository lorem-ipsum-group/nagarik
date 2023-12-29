import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nagarik/my_buttons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nagarik/my_colors.dart';
import 'package:nagarik/bottom_nav_bar.dart';
import 'package:nagarik/my_document.dart';
import 'package:nagarik/my_drawer.dart';

bool userNameFetched = false;
String userName = "";

class Home extends StatelessWidget {
  Home({required this.switchTab, required this.documents, super.key});

  final void Function(int index) switchTab;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final documents;
  final db = FirebaseFirestore.instance;

  Future<String> fetchUserName() async {
    if (!userNameFetched) {
      DocumentSnapshot user = await db.collection('users').doc("123").get();
      userName = user.get('name');
      userNameFetched = true;
    }
    return Future(() => userName);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchUserName(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // } else if (snapshot.hasError) {
          //   return Center(
          //     child: Text('Error: ${snapshot.error}'),
          //   );
          // } else {
          return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                backgroundColor: pastel,
                title: Text('Hi, ${snapshot.data}'),
                toolbarHeight: 50,
                leadingWidth: 100,
                leading: Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  clipBehavior: Clip.hardEdge,
                  child: const Image(
                      image: NetworkImage("https://plchldr.co/i/500x250")),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        scaffoldKey.currentState?.openEndDrawer();
                      },
                      icon: const Icon(Icons.more_vert))
                ],
              ),
              endDrawer: myDrawer(context),
              body: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    TopServices(items: [
                      TopServicesItem(
                          image: AssetImage('assets/Citizenship.png'),
                          label: "Citizenship",
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => Document(
                                        type: DocumentType.Citizenship,
                                      )))),
                      TopServicesItem(
                          image: AssetImage('assets/PAN logo.png'),
                          label: "PAN",
                          onTap: null),
                      TopServicesItem(
                          image: AssetImage('assets/Passport Card.png'),
                          label: "Passport",
                          onTap: null),
                      TopServicesItem(
                          image: AssetImage('assets/NID.png'),
                          label: "NID",
                          onTap: null),
                    ], bgColor: lightBlue, fgColor: blue),
                    IssuedDocuments(
                      documents: documents,
                      switchTab: (_) => switchTab(1),
                    ),
                    const AllServices(services: [
                      ServicesListItem(
                          icon: Icons.local_police,
                          label: "Police Clearance Report",
                          onTap: null),
                      ServicesListItem(
                          icon: Icons.how_to_vote,
                          label: "Voter Card",
                          onTap: null),
                      ServicesListItem(
                          icon: Icons.vaccines,
                          label: "Covid Vaccination",
                          onTap: null),
                      ServicesListItem(
                          icon: Icons.vertical_split_sharp,
                          label: "Press ID Card",
                          onTap: null),
                      ServicesListItem(
                          icon: Icons.security,
                          label: "Social Security Fund",
                          onTap: null),
                      ServicesListItem(
                          icon: Icons.feedback,
                          label: "My Complains",
                          onTap: null),
                      ServicesListItem(
                          icon: Icons.home_work, label: "Malpot", onTap: null),
                      ServicesListItem(
                          icon: Icons.health_and_safety,
                          label: "Health Insurance",
                          onTap: null),
                      ServicesListItem(
                          icon: Icons.emoji_people,
                          label: "Employee Provident Fund",
                          onTap: null),
                    ])
                  ])),
              bottomNavigationBar: MyBottomNavBar(
                currentTabIndex: 0,
                switchTab: switchTab,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: const FloatingActionButton(
                onPressed: null,
                shape: CircleBorder(),
                backgroundColor: blue,
                child: Icon(Icons.qr_code, color: white),
              ));
        });
  }
}

class TopServices extends StatelessWidget {
  const TopServices(
      {required this.items,
      this.bgColor = lightBlue,
      this.fgColor = darkGrey,
      super.key});

  final List<TopServicesItem> items;
  final Color bgColor;
  final Color fgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Top Services",
              style: TextStyle(
                  fontSize: 25, color: red, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                myTileButton(bgColor, fgColor, items[0].image, items[0].label,
                    onTap: items[0].onTap),
                const Spacer(),
                myTileButton(bgColor, fgColor, items[1].image, items[1].label,
                    onTap: items[1].onTap),
                const Spacer(),
                myTileButton(bgColor, fgColor, items[2].image, items[2].label,
                    onTap: items[2].onTap),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                myTileButton(bgColor, fgColor, items[3].image, items[3].label,
                    onTap: items[3].onTap)
              ],
            )
          ],
        ));
  }
}

class IssuedDocuments extends StatefulWidget {
  const IssuedDocuments(
      {required this.documents, required this.switchTab, super.key});

  final List<IssuedDocumentItem> documents;
  final void Function(int index) switchTab;

  @override
  State<IssuedDocuments> createState() => IssuedDocumentsState();
}

class IssuedDocumentsState extends State<IssuedDocuments> {
  final CarouselController _controller = CarouselController();

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text(
                  "Issued Documents",
                  style: TextStyle(
                      fontSize: 25, color: red, fontWeight: FontWeight.w600),
                ),
                IconButton(
                    onPressed: () => widget.switchTab(1),
                    icon: const Icon(
                      Icons.arrow_circle_right_outlined,
                      color: red,
                    ))
              ]),
              const SizedBox(height: 20),
              Align(
                  alignment: Alignment.centerLeft,
                  child: CarouselSlider.builder(
                    itemCount: widget.documents.length,
                    carouselController: _controller,
                    itemBuilder: (context, itemIndex, pageViewInex) {
                      return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
                          child: myPanelButton(widget.documents[itemIndex]));
                    },
                    options: CarouselOptions(
                        height: 170,
                        viewportFraction: 0.9,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentPage = index;
                          });
                        }),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.documents.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                        width: 12.0,
                        height: 12.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: entry.key == _currentPage ? red : fadedRed)),
                  );
                }).toList(),
              )
            ]));
  }
}

class AllServices extends StatelessWidget {
  const AllServices({required this.services, this.fgColor = blue, super.key});

  final List<ServicesListItem> services;
  final Color fgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "All Services",
                style: TextStyle(
                    fontSize: 25, color: red, fontWeight: FontWeight.w600),
              ),
              GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.1,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 20,
                  ),
                  itemCount: services.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return myGridButton(services[index], fgColor);
                  })
            ]));
  }
}
