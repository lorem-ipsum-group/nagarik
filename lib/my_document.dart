import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

var uid = "123";

enum DocumentType { Citizenship, NID, PAN }

Map<DocumentType, String> documentTypeString = {
  DocumentType.Citizenship: "Citizenship",
  DocumentType.NID: "NID",
  DocumentType.PAN: "PAN"
};

class Document extends StatelessWidget {
  Document({required this.type, super.key});

  final DocumentType type;
  Map<String, String>? documentData;

  Future<Map<String, dynamic>> fetchDocumentData() async {
    final db = FirebaseFirestore.instance;
    final user = await db.collection('users').doc(uid).get();
    final documentId = user.get("documents")["Citizenship"];
    final document = await db.collection("citizenships").doc(documentId).get();
    return Future.value(document.data());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchDocumentData(),
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const Center(child: CircularProgressIndicator());
          // } else if (snapshot.hasError) {
          //   return Center(
          //       child: Text('Error initializing data ${snapshot.error}'));
          // } else {
            return Scaffold(
                appBar: AppBar(
                  title: Text(documentTypeString[type]!),
                ),
                body: ListView(children: [
                  Container(
                    width: 435,
                    height: 420,
                    margin: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: const Color(0xA0F9CF58),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: 
                                const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset('assets/emblem.png',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                const Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          50, 0, 0, 0),
                                      child: Text(
                                        'नेपाल सरकार\nगृह मन्त्रालय\nजिल्ला प्रशासन कार्यालय, ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          color: Color(0xFFFF2B00),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          50, 5, 0, 0),
                                      child: Text(
                                        'नेपाली नागरिकताको प्रमाणपत्र',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'ना. प्र. नं.:',
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: const Color(0x9D14181B),
                                    fontSize: 12,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 0, 0),
                                  child: Text(
                                    snapshot.data!["id"] ?? ""
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(mainAxisSize: MainAxisSize.max, children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      18, 0, 0, 0),
                                  child: Text(
                                    'नाम थर: ',
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: const Color(0x9D14181B),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                SizedBox(
                                  width: 140,
                                  child: Text(
                                      (snapshot.data!["first_name_np"] ?? "") +
                                              " " +
                                              (snapshot
                                                  .data!["last_name_np"]) ??
                                          ""),
                                )
                              ]),
                              const SizedBox(width: 43),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'लिङ्ग: ',
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: const Color(0x9D14181B),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      snapshot.data!["gender_np"] ?? "",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          20, 0, 0, 0),
                                      child: Text(
                                        'जन्म स्थान: ',
                                        style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          color: const Color(0x9D14181B),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 40),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              'जिल्ला: ',
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                color: const Color(0x9D14181B),
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              snapshot.data![
                                                      "birth_district_np"] ??
                                                  "",
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              'गा. वि. स./न. पा.: ',
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                color: const Color(0x9D14181B),
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              snapshot.data![
                                                      "birth_admin_np"] ??
                                                  "",
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ]),
                              const SizedBox(width: 18),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'वडा न.:',
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: const Color(0x9D14181B),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                        snapshot.data!["birth_ward_np"] ?? ""),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        20, 0, 0, 0),
                                    child: Text(
                                      'स्थायी बासस्थान:',
                                      style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        color: const Color(0x9D14181B),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 18),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'जिल्ला: ',
                                            style: TextStyle(
                                              fontFamily: 'Readex Pro',
                                              color: const Color(0x9D14181B),
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(snapshot.data![
                                                  "permres_district_np"] ??
                                              ""),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'गा. वि. स./न. पा.: ',
                                            style: TextStyle(
                                              fontFamily: 'Readex Pro',
                                              color: const Color(0x9D14181B),
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(snapshot
                                                  .data!["permres_admin_np"] ??
                                              ""),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(width: 18),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'वडा न.:',
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: const Color(0x9D14181B),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                        snapshot.data!["permres_ward_np"] ??
                                            ""),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(mainAxisSize: MainAxisSize.max, children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 0, 0),
                                  child: Text(
                                    'जन्म मिति: ',
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: const Color(0x9D14181B),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 40),
                                Text(snapshot.data!["birthdate_np"] ?? ""),
                              ]),
                            ],
                          ),
                          Row(mainAxisSize: MainAxisSize.max, children: [
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                              child: Text(
                                'बाबुको नामथर:',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: const Color(0x9D14181B),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: 25),
                            Text(snapshot.data!["father_name_np"] ?? ""),
                          ]),
                          Row(mainAxisSize: MainAxisSize.max, children: [
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                              child: Text(
                                'ठेगाना: ',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: const Color(0x9D14181B),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: 56),
                            Text(snapshot.data!["father_addr_np"] ?? ""),
                          ]),
                          Row(mainAxisSize: MainAxisSize.max, children: [
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                              child: Text(
                                'आमाको नामथर:',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: const Color(0x9D14181B),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 18,
                            ),
                            Text(snapshot.data!["mother_name_np"] ?? ""),
                          ]),
                          Row(mainAxisSize: MainAxisSize.max, children: [
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                              child: Text(
                                'ठेगाना: ',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: const Color(0x9D14181B),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 56,
                            ),
                            Text(snapshot.data!["mother_addr_np"] ?? ""),
                          ]),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                                child: Text(
                                  'पति/पत्नीको नामथर: ',
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: const Color(0x9D14181B),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Text(snapshot.data!["spouse_name_np"] ?? ""),
                            ],
                          ),
                          Row(mainAxisSize: MainAxisSize.max, children: [
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                              child: Text(
                                'ठेगाना: ',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: const Color(0x9D14181B),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: 56),
                            Text(snapshot.data!["spouse_addr_np"] ?? ""),
                          ]),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: Container(
                      width: 435,
                      height: 400,
                      decoration: const BoxDecoration(
                        color: Color(0xA0F9CF58),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0, 15, 0, 0),
                                        child: Text(
                                          'Government of Nepal has issued this \nCitizenship Certificate with the following details.',
                                          style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            color: const Color(0x9D14181B),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  10, 5, 0, 0),
                                          child: Text(
                                            'Full name: \n(English)',
                                            style: TextStyle(
                                              fontFamily: 'Readex Pro',
                                              color: const Color(0x9D14181B),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 46),
                                        Text(
                                          snapshot.data!["name_en"] ?? "",
                                        ),
                                      ]),
                                  (const SizedBox(width: 20)),
                                  Align(
                                    alignment: AlignmentDirectional(1, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment: AlignmentDirectional(1, 0),
                                          child: Text(
                                            'Sex:',
                                            style: TextStyle(
                                              fontFamily: 'Readex Pro',
                                              color: const Color(0x9D14181B),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: AlignmentDirectional(1, 0),
                                          child: Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    9, 0, 3, 0),
                                            child: Text(
                                              snapshot.data!["gender_en"] ?? "",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          20, 0, 0, 0),
                                      child: Text(
                                        'Date of Birth:\n(AD)',
                                        style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          color: const Color(0x9D14181B),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 31),
                                    Text(
                                      snapshot.data!["birthdate_en"] ?? "",
                                      style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          20, 0, 0, 0),
                                      child: Text(
                                        'Birth Place:',
                                        style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          color: const Color(0x9D14181B),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 40),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              'District: ',
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                color: const Color(0x9D14181B),
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              snapshot.data!["birth_district_en"] ?? "",
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              'Municipality: ',
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                color: const Color(0x9D14181B),
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              snapshot.data!["birth_admin_en"] ?? "",
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 25),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      'Ward no:',
                                      style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        color: const Color(0x9D14181B),
                                        fontSize: 12,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          5, 0, 0, 0),
                                      child: Text(
                                        snapshot.data!["birth_ward_en"] ?? "",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(mainAxisSize: MainAxisSize.max, children: [
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            20, 0, 0, 0),
                                        child: Text(
                                          'Permanent \nAddress:',
                                          style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            color: const Color(0x9D14181B),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 40),
                                      Text(
                                        snapshot.data!["permres_district_en"] ?? "",
                                      ),
                                    ]),
                              ),
                              const SizedBox(width: 73),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Ward no:',
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: const Color(0x9D14181B),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      snapshot.data!["permres_ward_en"] ?? "",
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      20, 20, 0, 0),
                                  child: Text(
                                    'नेपाल नागरिकता ऐन २०६३ बमोजिम यो नागरिकताको प्रमाणपत्र \nदिइएको छ।  ',
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: const Color(0x9B14181B),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                  20, 5, 0, 0),
                                          child: Text(
                                            'नागरिकताको किसिम :',
                                            style: TextStyle(
                                              fontFamily: 'Readex Pro',
                                              color: const Color(0x9B14181B),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                  0, 5, 0, 0),
                                          child: Text(
                                            snapshot.data!["type_np"] ?? "",
                                          ),
                                        ),
                                      ]),
                                  const SizedBox(width: 20),
                                  Text(
                                    'प्रमाणपत्र जारि गर्ने अधिकारीको :',
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: const Color(0x9B14181B),
                                      fontSize: 12,
                                    ),
                                  ),
                                ]),
                            Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(20, 0, 0, 0),
                                              child: Text(
                                                '(दायाँ )',
                                                style: TextStyle(
                                                  fontFamily: 'Readex Pro',
                                                  color: const Color(0x9B14181B),
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(20, 5, 0, 0),
                                              child: Container(
                                                width: 30,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              '(बायाँ )',
                                              style: TextStyle(
                                                fontFamily: 'Readex Pro',
                                                color: const Color(0x9B14181B),
                                                fontSize: 12,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(0, 5, 0, 0),
                                              child: Container(
                                                width: 30,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                  const SizedBox(width: 80),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'नाम थर :',
                                            style: TextStyle(
                                              fontFamily: 'Readex Pro',
                                              color: const Color(0x9B14181B),
                                              fontSize: 12,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    5, 0, 0, 0),
                                            child: Text(
                                              snapshot.data!["issuer_name_np"] ?? ""
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'दर्जा :',
                                            style: TextStyle(
                                              fontFamily: 'Readex Pro',
                                              color: const Color(0x9B14181B),
                                              fontSize: 12,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    10, 0, 0, 0),
                                            child: Text(
                                              snapshot.data!["issuer_post_np"] ?? ""
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'जारि मिति :',
                                            style: TextStyle(
                                              fontFamily: 'Readex Pro',
                                              color: const Color(0x9B14181B),
                                              fontSize: 12,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    5, 0, 0, 0),
                                            child: Text(
                                              snapshot.data!["issue-date_np"] ?? ""
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                          ],
                        ),
                      ),
                    ),
                  )
                ]));
          }
        );
  }
}
