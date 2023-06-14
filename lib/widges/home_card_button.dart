
import 'package:flutter/material.dart';

import '../utils/myStyle.dart';
class HomeCardButton extends StatelessWidget {
   HomeCardButton({
    super.key, this.cardText,
     required this.onTap,
     required this.iconData
  });

  VoidCallback onTap;
  final cardText;
  IconData iconData;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: const Border.fromBorderSide(BorderSide(color: Colors.orange)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
             Container(
               width: 40,
              height: 40,
              child: Icon(iconData,size: 50,)
            ),
            const SizedBox(height: 24,),
            Text(cardText,style: MyStyle.subTitleStyle(),)
          ],
        ),
      ),
    );
  }
}
