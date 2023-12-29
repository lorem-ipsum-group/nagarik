import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nagarik/chat_screen.dart';
import 'package:nagarik/main.dart';
import 'package:nagarik/my_buttons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nagarik/my_colors.dart';
import 'package:nagarik/bottom_nav_bar.dart';
import 'package:nagarik/my_document.dart';

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
              endDrawer: Drawer(
                elevation: 5,
                backgroundColor: white,
                width: 220,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: const BoxDecoration(
                        color: lightBlue,
                      ),
                      child: Center(
                        child: Image.asset('assets/logo.png',
                            width: 100, height: 100),
                      ),
                    ),
                    ListTile(
                      title: const Center(
                          child: Text('Live Chat',
                              style: TextStyle(
                                  color: lightGrey,
                                  fontWeight: FontWeight.w400))),
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => ChatScreen()));
                      },
                    ),
                    ListTile(
                      title: const Center(
                          child: Text(
                        'Logout',
                        style: TextStyle(
                            color: lightGrey, fontWeight: FontWeight.w400),
                      )),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => AuthenticationPage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              body: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    TopServices(items: [
                      TopServicesItem(
                          icon: Icons.credit_card,
                          label: "Citizenship",
                          onTap: () => Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) => Document(type: DocumentType.Citizenship,)))),
                      TopServicesItem(
                          icon: Icons.credit_card, label: "PAN", onTap: () => Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) => Document(type: DocumentType.Citizenship,)))),
                      TopServicesItem(
                          icon: Icons.credit_card,
                          label: "Passport",
                          onTap: () => Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) => Document(type: DocumentType.Citizenship,)))),
                    ], bgColor: lightBlue, fgColor: blue),
                    IssuedDocuments(
                      documents: documents,
                      switchTab: switchTab,
                    ),
                    AllServices(services: [
                      ServicesListItem(
                          icon: Icons.credit_card,
                          label: "Citizenship",
                          onTap: () => Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) => Document(type: DocumentType.Citizenship,)))),
                      const ServicesListItem(
                          icon: Icons.credit_card,
                          label: "PAN",
                          onTap: null),
                      const ServicesListItem(
                          icon: Icons.credit_card,
                          label: "Passport",
                          onTap: null),
                      const ServicesListItem(
                          icon: Icons.credit_card,
                          label: "NID",
                          onTap: null),
                      const ServicesListItem(
                          icon: Icons.credit_card,
                          label: "Education",
                          onTap: null),
                      const ServicesListItem(
                          icon: Icons.credit_card,
                          label: "NOC",
                          onTap: null),
                      const ServicesListItem(
                          icon: Icons.credit_card,
                          label: "Complaints",
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
      this.bgColor = Colors.blue,
      this.fgColor = Colors.black,
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
                myTileButton(bgColor, fgColor, items[0].icon, items[0].label,
                    onTap: items[0].onTap),
                const Spacer(),
                myTileButton(bgColor, fgColor, items[1].icon, items[1].label,
                    onTap: items[1].onTap),
                const Spacer(),
                myTileButton(bgColor, fgColor, items[2].icon, items[2].label,
                    onTap: items[1].onTap),
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
