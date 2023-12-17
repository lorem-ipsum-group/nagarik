import 'package:flutter/material.dart';
import 'package:nagarik/my_colors.dart';

class TopServicesItem {
  TopServicesItem({required this.icon, required this.label, required this.onTap});
  
  IconData icon;
  String label;
  void Function()? onTap;
}

ElevatedButton myTileButton(Color bgColor, Color fgColor, IconData icon, String label, {double fontSize = 14, void Function()? onTap}) {
  return ElevatedButton(
    onPressed: onTap,
    
    style: ButtonStyle(
      backgroundColor:MaterialStateProperty.all(bgColor),
      surfaceTintColor:MaterialStateProperty.all(bgColor),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      fixedSize: MaterialStateProperty.all(const Size(100, 100)),
      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 20, horizontal: 10)),
      shadowColor: MaterialStateProperty.all(Colors.black),
      elevation: MaterialStateProperty.all(5),
    ),
    
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon,  ),
        const Spacer(flex: 2,),
        Text(label, style: TextStyle(color: fgColor, fontSize: fontSize),)
      ],
    ),
  );
}

class IssuedDocumentItem {
  IssuedDocumentItem({required this.title, required this.id, this.subtitle, this.image, this.onTap});
  
  String title;
  String? subtitle;
  String id;
  Image? image;
  void Function()? onTap;
}

ElevatedButton myPanelButton(IssuedDocumentItem item) {
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
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        fixedSize: MaterialStateProperty.all(const Size(300, 150)),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 20, horizontal: 10)),
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

class ServicesListItem {
  const ServicesListItem(
      {required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final void Function()? onTap;
}


ElevatedButton myGridButton(ServicesListItem item, Color color) {
  return ElevatedButton(
    onPressed: item.onTap,
    style: const ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(Colors.transparent),
      surfaceTintColor: MaterialStatePropertyAll(Colors.transparent),
      elevation: MaterialStatePropertyAll(0),
      padding: MaterialStatePropertyAll(EdgeInsets.all(0)),
      
    ),
    
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          item.icon,
          color: color,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          item.label,
          style: TextStyle(color: color),
        )
      ],
    ),
  );
}
