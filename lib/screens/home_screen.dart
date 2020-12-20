import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fitizmir/screens/hazir_diyetler_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        bottom: false,
        left: true,
        right: true,
        child: Container(
          height: mediaQuery.size.height,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: (mediaQuery.size.height -
                    mediaQuery.padding.top) *
                    0.25
                ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
//                  color: Theme.of(context).accentColor,
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                      child: Image(
                        image: AssetImage('assets/images/logo1.png'),
                        width: 160,
                        height: 160,
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: ClipOval(
                        child: Image(
                          image: AssetImage('assets/images/fitIzmirresim.png'),
                          fit: BoxFit.cover,
                          width: 160,
                          height: 160,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: (mediaQuery.size.height -
              mediaQuery.padding.top) *
                  0.75,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(1),
                  children: <Widget>[
                    Container(
                      child: InkWell(
                        onTap: () {
                          print("profil");
                        },
                        child: Image(
                          image: AssetImage("assets/images/profil.png"),
                        ),
                      ),
                    ),
                    Container(
                      child: InkWell(
                        onTap: () {
                          print("profil");
                        },
                        child: Image(
                          image: AssetImage("assets/images/ekibimiz.jpg"),
                        ),
                      ),
                    ),
                    Container(
                      child: InkWell(
                        onTap: () {
                          print("profil");
                        },
                        child: Image(
                          image: AssetImage("assets/images/blog.jpg"),
                        ),
                      ),
                    ),
                    Container(
                      child: InkWell(
                        onTap: () {},
                        child: Image(
                          image: AssetImage("assets/images/onlinediyet.jpg"),
                        ),
                      ),
                    ),
                    Container(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(HazirDiyetlerScreen.routeName);
                        },
                        child: Image(
                          image: AssetImage("assets/images/ozeldiyetler.jpg"),
                        ),
                      ),
                    ),
                    Container(
                      child: InkWell(
                        onTap: () {
                          print("profil");
                        },
                        child: Image(
                          image: AssetImage("assets/images/kilokoruma.jpg"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
