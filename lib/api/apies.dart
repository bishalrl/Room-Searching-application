import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:room_chha/messege/model/message.dart';

import '../chatandmessages_room/chatusermodeule.dart';

class Apie {
  static FirebaseAuth auth = FirebaseAuth.instance;
  //id
  //for authintication
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  //for firestore
  static FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  // for storing in firebase

  ///***kei */

  static String getConvesationID(String id) =>
      auth.currentUser!.uid.hashCode <= id.hashCode
          ? '${auth.currentUser!.uid}_$id'
          : '${id}_${auth.currentUser!.uid}';
  //stream querry
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUser user) {
    // Replace 'messages' with the actual name of your Firestore collection
    return firestore
        .collection('chats/${getConvesationID(user.userId)}/message/')
        .snapshots();
  }

  static Future<void> sendMessage(ChatUser user, String msg) async {
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    //message to send
    final Message message = Message(
        msg: msg,
        toId: user.friendUid,
        read: '',
        type: Type.text,
        sent: time,
        fromId: auth.currentUser!.uid);

    final ref =
        firestore.collection('chats/${getConvesationID(user.userId)}/message/');

    await ref.doc(time).set(message.toJson());
  }
}
