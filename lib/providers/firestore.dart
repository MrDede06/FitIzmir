import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

var firestore = Firestore.instance;

Future getCategoriestmp() async {
  QuerySnapshot qn = await firestore.collection("Category").getDocuments();
  return qn.documents;
}

/*
Future getSubCategories() async {
  QuerySnapshot qn = await firestore
      .collection("Category")
      .getDocuments()
      .then((querysnaphot) {
        querysnaphot.documents.forEach((result) { })
      });

  return qn;
}
*/

Future getSubCategoriestmp() async {
  QuerySnapshot qn = await firestore
      .collection("Category")
      .getDocuments()
      .then((querySnapshot) {
    querySnapshot.documents.forEach((result) {
      firestore
          .collection("Category")
          .document(result.documentID)
          .collection("Subcategory")
          .getDocuments()
          .then((querySnapshot) {
        querySnapshot.documents.forEach((result) {
          return result.documentID;
        });
      });
    });
  });

  return qn;
}
/*
Future getSubcategories() async {
  List SubaccountList = await Firestore.instance
      .collection("Category")
      .getDocuments()
      .then((val) => val.documents);

  for (int i = 0; i < SubaccountList.length; i++) {
    return Firestore.instance
        .collection("Category")
        .document(SubaccountList[i].documentID.toString())
        .collection("Subcategory")
        .getDocuments()
        .then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        return result;
      });
    });
  }
}
*/

Future getSubcategories() async {
  List SubaccountList = await Firestore.instance
      .collection("Category")
      .getDocuments()
      .then((val) => val.documents);

  for (int i = 0; i < SubaccountList.length; i++) {
    return Firestore.instance
        .collection("Category")
        .document(SubaccountList[i].documentID.toString())
        .collection("Subcategory")
        .getDocuments()
        .then((value) => value.documents);
  }
}
