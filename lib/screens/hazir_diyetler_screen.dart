import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitizmir/screens/hazir_diyet_detay_screen.dart';

class HazirDiyetScreenArgs {
  final String isim;
  final String aciklama;
  final bool bedava;
  final double fiyat;
  final String pdf;
  final String resim;
  HazirDiyetScreenArgs(
      this.isim, this.fiyat, this.aciklama, this.bedava, this.pdf, this.resim);
}

class HazirDiyetlerScreen extends StatefulWidget {
  static const routeName = '/hazirdiyetler';

  @override
  _HazirDiyetlerScreenState createState() => _HazirDiyetlerScreenState();
}

class _HazirDiyetlerScreenState extends State<HazirDiyetlerScreen> {
  bool selected = false;
  Widget build(BuildContext context) {
    final screen_width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Özel Diyetler",
            style: GoogleFonts.pacifico(),
          )),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("HazirPaketler").snapshots(),
        builder: (ctx, categorySnapshot) {
          if (categorySnapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();
          final paketler = categorySnapshot.data.documents;
          return GridView.builder(
            primary: false,
            padding: const EdgeInsets.all(2),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 2, mainAxisSpacing: 2, crossAxisCount: 2),
            itemCount: paketler.length,
            itemBuilder: (ctx, index) => InkWell(
              onTap: () => {
                Navigator.pushNamed(
                  ctx,
                  HazirDiyetlerDetayScreen.routeName,
                  arguments: HazirDiyetScreenArgs(
                    paketler[index]['isim'],
                    paketler[index]['fiyat'].toDouble(),
                    paketler[index]['aciklama'],
                    paketler[index]['bedava'],
                    paketler[index]['pdf'],
                    paketler[index]['resim'],
                  ),
                )
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                margin: EdgeInsets.all(5),
                child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        child: Image.network(
                          paketler[index]['resim'],
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        child: SizedBox(
                          width: (screen_width - 10) / 2,
                          child: Container(
                            color: Colors.black54,
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 5,
                            ),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  paketler[index]['isim'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontFamily: 'RobotoCondensed',
                                    fontWeight: FontWeight.bold,
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                Text(
                                  (paketler[index]['fiyat'] == 0)
                                      ? "BEDAVA!"
                                      : paketler[index]['fiyat'].toString() +
                                          '₺',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green,
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

              ),
            ),
          );
        },
      ),
    );
  }
}
