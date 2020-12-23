import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitizmir/screens/hazir_diyetler_screen.dart';

class HazirDiyetlerDetayScreen extends StatelessWidget {
  static const routeName = '/hazirdiyetlerdetay';
  Widget build(BuildContext context) {
    final HazirDiyetScreenArgs args = ModalRoute.of(context).settings.arguments;
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Diyet Özeti",
            style: GoogleFonts.pacifico(),
          )),
      body: Column(
        children: <Widget>[
          Container(
            height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.25,
            width: double.infinity,
            child: Image.network(
              args.resim,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.04,
            margin: EdgeInsets.all(10),
            child: Text(
              args.isim,
              style: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.06,
            child: InkWell(
              onTap: () => print("dsfjdjkfas"),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.all(10),
                child: (args.fiyat == 0) ?  Text(
                  "Indir",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                )
                : Text(
                  "Satın Al" + "  " + args.fiyat.toString() + '₺',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),

    ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
            height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.5,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                border: Border.all(color: Colors.grey),
              ),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              padding: EdgeInsets.all(5),
              child: Text(
                args.aciklama,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),

          ),
        ],
      ),

    );
  }
}
