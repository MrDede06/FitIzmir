import 'package:flutter_bounce/flutter_bounce.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitizmir/screens/hazir_diyetler_screen.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HazirDiyetlerDetayScreen extends StatefulWidget {
  static const routeName = '/hazirdiyetlerdetay';

  @override
  _HazirDiyetlerDetayScreenState createState() =>
      _HazirDiyetlerDetayScreenState();
}

class _HazirDiyetlerDetayScreenState extends State<HazirDiyetlerDetayScreen> {
  bool selected = false;

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
              child: (args.fiyat == 0)
                  ? InkWell(
                      onTap: () async {
                        setState(() {
                          selected = !selected;
                        });
                        final status = await Permission.storage.request();
                        if (status.isGranted) {
                          final externalDir =
                              await getExternalStorageDirectory();
                          final id = await FlutterDownloader.enqueue(
                            url: args.pdf,
                            savedDir: externalDir.path,
                            fileName: "download.pdf",
                            showNotification: true,
                            openFileFromNotification: true,
                          );
                        } else {
                          print("Permission deined");
                        }
                        setState(() {
                          selected = !selected;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 100),
                        curve: Curves.fastOutSlowIn,
                        decoration: BoxDecoration(
                          color: selected ?  Colors.blueGrey : Colors.blueGrey[50],
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(2),
                        padding: EdgeInsets.all(10),
                        width: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "İndir",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.file_download,
                              color: Colors.black,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () => {setState(() {
                        selected = !selected;
                      }),
                      },
                      child: AnimatedContainer(
                       // width: selected ? 200.0 : 100.0,
                       // height: selected ? 100.0 : 200.0,
                        duration: Duration(milliseconds: 100),
                        curve: Curves.fastOutSlowIn,
                        decoration: BoxDecoration(
                          color: selected ?  Colors.blueGrey : Colors.blueGrey[50],
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(2),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Satın Al" + "  " + args.fiyat.toString() + '₺',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )),
          Container(
            height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.5,
//            decoration: BoxDecoration(
//              color: Colors.blueGrey,
//              border: Border.all(color: Colors.grey),
//            ),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            padding: EdgeInsets.all(5),
            child: SingleChildScrollView(
              child: Text(
                args.aciklama.replaceAll("\\n", "\n"),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
