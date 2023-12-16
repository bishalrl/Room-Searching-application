import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

ADDRoom(String totalRoom, String roomLocation, String discription,
    String roomPrice, File? image1, File? image2, File? image3) async {
  User? user = FirebaseAuth.instance.currentUser;

  try {
    if (user != null) {
      String uid = user.uid;

      await FirebaseFirestore.instance.collection("Rooms").doc(uid).set({
        "Total Room": totalRoom,
        "Room Location": roomLocation,
        "Discription": discription,
        "Room price": roomPrice,
        "Image 1": image1,
        "Image 2": image2,
        "Image 3": image3,
        "createdAt": DateTime.now(),
        "uid": uid,
      });
    }
  } on FirebaseAuthException catch (e) {
    print("error $e");
  }
}
