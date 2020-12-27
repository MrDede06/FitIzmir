import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitizmir/screens/hazir_diyetler_screen.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class HazirDiyetlerDetayScreen extends StatefulWidget {
  static const routeName = '/hazirdiyetlerdetay';

  @override
  _HazirDiyetlerDetayScreenState createState() =>
      _HazirDiyetlerDetayScreenState();
}

class _HazirDiyetlerDetayScreenState extends State<HazirDiyetlerDetayScreen> {
  var dio = Dio();
  void initState(){
    getPermission();
  }
  void getPermission() async {
    print("getPermission");
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }

  Future download2(Dio dio, String url, String savePath) async {
    //get pdf from link
    print("functin called");
    final PermissionHandler _permissionHandler = PermissionHandler();
    var result = await _permissionHandler.requestPermissions([PermissionGroup.storage]);
    print(result);
    if (result[PermissionGroup.storage] == PermissionStatus.granted) {
    Response response = await dio.get(
      url,
//      onReceiveProgress: showDownloadProgress,
      //Received data with List<int>
      options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          }),
    );

    //write in download folder
    File file = File(savePath);
    var raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();}
  }
  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }

  Future<void> download3() async{
    print("function called");
  }

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
                      onTap: ()async{
//                        String path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
//                        String directory = await StoragePath.filePath;
                        final directory = await getApplicationDocumentsDirectory();
//                        print(directory);
//                        String fullPath = "${directory}/diyet.pdf";
//                        Dio dio = Dio();
//                        await dio.download(args.pdf, directory.path);

                        download2(dio, args.pdf, directory.path);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: EdgeInsets.all(2),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Indir",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          )),
                    )
                  : InkWell(
                      onTap: () => print("Satin al"),
                      splashColor: Colors.blueGrey,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(2),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Satın Al" + "  " + args.fiyat.toString() + '₺',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )),
          Container(
            height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.5,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              border: Border.all(color: Colors.grey),
            ),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            padding: EdgeInsets.all(5),
            child: SingleChildScrollView(
              child: Text(
                args.aciklama.replaceAll("\\n", "\n"),
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
