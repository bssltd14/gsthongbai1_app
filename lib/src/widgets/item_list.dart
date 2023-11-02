
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemList extends StatelessWidget {
  final String no;
  final String texto;
  final String price;

  const ItemList({Key key, this.no, this.texto, this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(width: 5),
            Text(
              no,
              style: GoogleFonts.kodchasan().copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18)),

            Text(
              texto,
              style: GoogleFonts.kodchasan().copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18),
            ),

            Text(
              price,
              style: GoogleFonts.kodchasan().copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18),
            ),
            SizedBox(width: 5)
          ],
        ),

      ),
    );
  }
}
