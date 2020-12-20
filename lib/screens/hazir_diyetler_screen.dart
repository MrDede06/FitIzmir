import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HazirDiyetlerScreen extends StatelessWidget{

  static const routeName = '/hazirdiyetler';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Özel Diyetler",
          style: GoogleFonts.pacifico(),

        )
      ),
      body: Text('fsdafadfas'),
    );
  }
}