import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room_chha/messege/model/message.dart';

class MessageCaed extends StatefulWidget {
  const MessageCaed({super.key, required this.message});
  final Message message;

  @override
  State<MessageCaed> createState() => _MessageCaedState();
}

class _MessageCaedState extends State<MessageCaed> {
  @override
  Widget build(BuildContext context) {
    // final isSender =
    //     FirebaseAuth.instance.currentUser!.uid == widget.message.fromId;
    // log('Current User ID: ${FirebaseAuth.instance.currentUser!.uid}');
    // log('Message To ID: ${widget.message.toId}');

    // return isSender ? _greenMessage() : _blueMessage();
//   }
    return FirebaseAuth.instance.currentUser!.uid == widget.message.toId
        ? _greenMessage()
        : _blueMessage();
  }

//message for sender
  Widget _blueMessage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                color: const Color.fromARGB(255, 208, 229, 246),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
              padding: const EdgeInsets.all(20),
              child: Text(
                widget.message.msg,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          //time
          // SizedBox(
          //   width: 15,
          // ),
          // Text(
          //   widget.message.sent,
          //   style: TextStyle(fontSize: 15),
          // )
        ],
      ),
    );
  }

  //message for reciver
  Widget _greenMessage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Padding(padding: EdgeInsets.only(right: 280)),
          // Text(
          //   widget.message.sent,
          //   style: TextStyle(fontSize: 15),
          // ),
          //time
          SizedBox(
            width: 15,
          ),

          Flexible(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                color: Color.fromARGB(255, 212, 246, 208),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
              ),
              padding: EdgeInsets.all(20),
              child: Text(
                widget.message.msg,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
  //message for reciver
}
// import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:room_chha/messege/model/message.dart';

// class MessageCard extends StatefulWidget {
//   const MessageCard({Key? key, required this.message});
//   final Message message;

//   @override
//   State<MessageCard> createState() => _MessageCardState();
// }

// class _MessageCardState extends State<MessageCard> {
//   @override
//   Widget build(BuildContext context) {
//     // Check if the current user is the sender (based on toId)
//     final isSender =
//         FirebaseAuth.instance.currentUser!.uid == widget.message.fromId;
//     log('Current User ID: ${FirebaseAuth.instance.currentUser!.uid}');
//     log('Message To ID: ${widget.message.toId}');

//     return isSender ? _greenMessage() : _blueMessage();
//   }

//   // Widget for sender's message
//   Widget _blueMessage() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Flexible(
//             child: Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.blue),
//                 color: const Color.fromARGB(255, 208, 229, 246),
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(30),
//                   topRight: Radius.circular(30),
//                   bottomRight: Radius.circular(30),
//                 ),
//               ),
//               padding: EdgeInsets.all(20),
//               child: Text(
//                 widget.message.msg,
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//           ),
//           // Add time or other message-related information if needed
//         ],
//       ),
//     );
//   }

//   // Widget for receiver's message
//   Widget _greenMessage() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Flexible(
//             child: Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.green),
//                 color: Color.fromARGB(255, 212, 246, 208),
//                 borderRadius: const BorderRadius.only(
//                   bottomLeft: Radius.circular(30),
//                   topRight: Radius.circular(30),
//                   topLeft: Radius.circular(30),
//                 ),
//               ),
//               padding: EdgeInsets.all(20),
//               child: Text(
//                 widget.message.msg,
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//           ),
//           // Add time or other message-related information if needed
//         ],
//       ),
//     );
//   }
// }
