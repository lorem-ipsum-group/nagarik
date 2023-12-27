import 'package:nagarik/my_colors.dart';

import 'package:flutter/material.dart';

enum DocumentListType { issuedDocuments, uploadedDocuments }

class DocumentTileItem {
  DocumentTileItem(
      {required this.title,
      required this.id,
      required this.unlink,
      this.image,
      this.subtitle,
      this.onTap});

  String title;
  String? subtitle;
  String id;
  Image? image;
  void Function()? onTap;
  void Function()? unlink;
}

class Documents extends StatefulWidget {
  Documents(
      {this.documentListType = DocumentListType.issuedDocuments,
      this.issuedDocuments = const <DocumentTileItem>[],
      this.uploadedDocuments = const <DocumentTileItem>[],
      super.key});

  DocumentListType documentListType;
  late List<DocumentTileItem> issuedDocuments;
  late List<DocumentTileItem> uploadedDocuments;

  @override
  State<Documents> createState() => DocumentsState();
}

class DocumentsState extends State<Documents> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.documentListType = DocumentListType.issuedDocuments;
                  });
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        widget.documentListType ==
                                DocumentListType.issuedDocuments
                            ? red
                            : Colors.grey),
                    fixedSize: const MaterialStatePropertyAll(Size(150, 50)),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))
                  ),
                child: const Center(
                    child: Text(
                  "Issued",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ))),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.documentListType =
                        DocumentListType.uploadedDocuments;
                  });
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        widget.documentListType == DocumentListType.uploadedDocuments
                            ? red
                            : Colors.grey),
                    fixedSize: const MaterialStatePropertyAll(Size(150, 50)),
                    shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)))),
                child: const Center(
                  child: Text(
                    "Uploads",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ))
          ],
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: widget.documentListType == DocumentListType.issuedDocuments
            ? widget.issuedDocuments.length
            : widget.uploadedDocuments.length,
            itemBuilder: (context, index) {
              return documentTile(widget.documentListType == DocumentListType.issuedDocuments
                ? widget.issuedDocuments[index]
                : widget.uploadedDocuments[index]);
            },
        ))
      ],
    );
  }
}

ElevatedButton documentTile(DocumentTileItem item) {
  const bgColor = pastel;
  final placeholderImage = item.image ??
      const Image(
          image: NetworkImage(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Emblem_of_Nepal.svg/1200px-Emblem_of_Nepal.svg.png"));

  return ElevatedButton(
      onPressed: item.onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(bgColor),
        surfaceTintColor: MaterialStateProperty.all(bgColor),
        
        fixedSize: MaterialStateProperty.all(const Size(300, 150)),        
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 20, horizontal: 10)),

        shadowColor: MaterialStateProperty.all(Colors.black),
        elevation: MaterialStateProperty.all(5),
      ),
      
      child: SizedBox(
        height: 150,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 75, width: 75, child: placeholderImage),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(item.title,
                        style:
                            const TextStyle(fontSize: 24, color: Colors.grey)),
                    Text(item.id,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.grey)),
                  ],
                )),
                IconButton(
                    onPressed: item.unlink,
                    icon: const Icon(
                      Icons.link_off,
                      size: 40,
                      color: red,
                    ))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(item.subtitle!,
                style: const TextStyle(fontSize: 15, color: Colors.grey)),
          ],
        ),
      ));
}
