import 'package:flutter/material.dart';
import 'package:room_chha/api/apies.dart';
import 'package:room_chha/chatandmessages_room/chatcard.dart';

import 'chatusermodeule.dart';

class ChatMainScreen extends StatefulWidget {
  const ChatMainScreen({super.key});

  @override
  State<ChatMainScreen> createState() => _ChatMainScreenState();
}

class _ChatMainScreenState extends State<ChatMainScreen> {
  List<ChatUser> list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Talk to owener"),
        ),
        body: StreamBuilder(
            stream: Apie.firestore.collection("chatuser").snapshots(),
            builder: ((context, snapshot) {
              switch (snapshot.connectionState) {
                //IF data is loading
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                //if some data or all data is loaded then show it
                case ConnectionState.active:
                case ConnectionState.done:
                  {
                    final data = snapshot.data!.docs;
                    list = data
                            ?.map((e) => ChatUser.fromJson(e.data()))
                            .toList() ??
                        [];
                  }
                  if (list.isNotEmpty) {
                    return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return ChatCard(
                            user: list[index],
                          );
                        });
                  } else {
                    return Center(
                        child: Text(
                      "No Connection found",
                      style: TextStyle(fontSize: 30),
                    ));
                  }
              }
            })));
  }
}
