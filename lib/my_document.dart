import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

var uid = "123";

enum DocumentType { Citizenship, NID, PAN }

Map<DocumentType, String> documentTypeString = {
  DocumentType.Citizenship: "citizenship",
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
    print(user);
    final documentId = user.get("documents")["citizenship"];
    print(documentId);
    final document =
        await db.collection("citizenships").doc(documentId).get();
    print(document.data());
    return Future.value(document.data());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchDocumentData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error initializing data ${snapshot.error}'));
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text(documentTypeString[type]!),
              ),
              body: Container(
  width: 435,
  height: 420,
  margin: EdgeInsets.all(10),
  decoration: BoxDecoration(
    color: Color(0xA0F9CF58),
  ),
  child: Padding(
    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Emblem_of_Nepal.svg/1200px-Emblem_of_Nepal.svg.png",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 20),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(50, 0, 0, 0),
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
                    padding: EdgeInsetsDirectional.fromSTEB(50, 5, 0, 0),
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
          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'ना. प्र. नं.:',
                style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Color(0x9D14181B),
                      fontSize: 12,
                    ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                child: Text(
                  'xx-xx-xx-xxxxx',
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
         
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
                  child: Text(
                    'नाम थर: ',
                    style: TextStyle(
                          fontFamily: 'Readex Pro',
                          color: Color(0x9D14181B),
                          fontSize: 12,
                        ),
                  ),
                ),
                SizedBox(width: 50,),
                SizedBox(
                  width: 140,
                  child: Text(
                    (snapshot.data!["first_name_np"] ?? "") + " " + (snapshot.data!["last_name_np"]) ?? ""
                  ),
                )
              ]
            ),
            SizedBox(width: 43),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'लिङ्ग: ',
                  style: TextStyle(
                        fontFamily: 'Readex Pro',
                        color: Color(0x9D14181B),
                        fontSize: 12,
                      ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
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
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                  child: Text(
                    'जन्म स्थान: ',
                    style: TextStyle(
                          fontFamily: 'Readex Pro',
                          color: Color(0x9D14181B),
                          fontSize: 12,
                        ),
                  ),
                ),
                SizedBox(width: 40),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'जिल्ला: ',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Color(0x9D14181B),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          snapshot.data!["birth_district_np"] ?? "",
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
                            color: Color(0x9D14181B),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          snapshot.data!["birth_admin_np"] ?? "",
                        ),
                      ],
                    ),
                  ],
                ),
              ]
            ),
            SizedBox(width: 18),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'वडा न.:',
                  style: TextStyle(
                        fontFamily: 'Readex Pro',
                        color: Color(0x9D14181B),
                        fontSize: 12,
                      ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                  child: Text(
                    snapshot.data!["birth_ward_np"] ?? ""
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
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                  child: Text(
                    'स्थायी बासस्थान:',
                    style: TextStyle(
                          fontFamily: 'Readex Pro',
                          color: Color(0x9D14181B),
                          fontSize: 12,
                        ),
                  ),
                ),
                SizedBox(width: 18),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'जिल्ला: ',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            color: Color(0x9D14181B),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          snapshot.data!["permres_district_np"] ?? ""
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
                            color: Color(0x9D14181B),
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          snapshot.data!["permres_admin_np"] ?? ""
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: 18),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'वडा न.:',
                  style: TextStyle(
                        fontFamily: 'Readex Pro',
                        color: Color(0x9D14181B),
                        fontSize: 12,
                      ),
                ),

                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                  child: Text(
                    snapshot.data!["permres_ward_np"] ?? ""
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                  child: Text(
                    'जन्म मिति: ',
                    style: TextStyle(
                          fontFamily: 'Readex Pro',
                          color: Color(0x9D14181B),
                          fontSize: 12,
                        ),
                  ),
                ),
                SizedBox(width: 40),
                Text(
                  snapshot.data!["birthdate_np"] ?? ""
                ),
              ]
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
              child: Text(
                'बाबुको नामथर:',
                style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Color(0x9D14181B),
                      fontSize: 12,
                    ),
              ),
            ),
            SizedBox(width: 25),
            Text(
              snapshot.data!["father_name_np"] ?? ""
            ),
          ]
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
              child: Text(
                'ठेगाना: ',
                style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Color(0x9D14181B),
                      fontSize: 12,
                    ),
              ),
            ),
            SizedBox(width: 56),
            Text(
              snapshot.data!["father_addr_np"] ?? ""
            ),
          ]
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
              child: Text(
                'आमाको नामथर:',
                style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Color(0x9D14181B),
                      fontSize: 12,
                    ),
              ),
            ),
            SizedBox(width: 18,),
            Text(
              snapshot.data!["mother_name_np"] ?? ""
            ),
          ]
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
              child: Text(
                'ठेगाना: ',
                style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Color(0x9D14181B),
                      fontSize: 12,
                    ),
              ),
            ),
            SizedBox(width: 56,),
            Text(
              snapshot.data!["mother_addr_np"] ?? ""
            ),
          ]
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
              child: Text(
                'पति/पत्नीको नामथर: ',
                style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Color(0x9D14181B),
                      fontSize: 12,
                    ),
              ),
            ),
            Text(
              snapshot.data!["spouse_name_np"] ?? ""
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
              child: Text(
                'ठेगाना: ',
                style: TextStyle(
                      fontFamily: 'Readex Pro',
                      color: Color(0x9D14181B),
                      fontSize: 12,
                    ),
              ),
            ),
            SizedBox(width: 56),
            Text(
              snapshot.data!["spouse_addr_np"] ?? ""
            ),
          ]
        ),
      ],
    ),
  ),
)
,
            );
          }
        });
  }
}
