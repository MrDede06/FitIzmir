import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HazirDiyetlerScreen extends StatelessWidget {
  static const routeName = '/hazirdiyetler';

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Özel Diyetler",
            style: GoogleFonts.pacifico(),
          )),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("HazirPaketler").snapshots(),
        builder: (ctx, categorySnapshot){
          final paketler = categorySnapshot.data.documents;
          return GridView.builder(
            primary: false,
            padding: const EdgeInsets.all(2),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 2, mainAxisSpacing: 2, crossAxisCount: 2),
            itemCount: paketler.length,
            itemBuilder: (ctx, index) => InkWell(
              onTap: () => print("print"),
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
                      right: 10,
                      child: Container(
                        width: 150,
                        color: Colors.black54,
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 5,
                        ),
                        child: Text(
                          paketler[index]['isim'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.fade,
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
