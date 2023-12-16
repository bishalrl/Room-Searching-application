import 'dart:convert';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room_chha/api/apies.dart';
import 'package:room_chha/chatandmessages_room/chatusermodeule.dart';
import 'package:room_chha/messege/message_card.dart';
import 'package:room_chha/messege/model/message.dart';

class Messenger extends StatefulWidget {
  final ChatUser user;
  const Messenger({super.key, required this.user});

  @override
  State<Messenger> createState() => _MessengerState();
}

class _MessengerState extends State<Messenger> {
  @override
  List<Message> _list = [];
  final _textcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.name),
      ),
      backgroundColor: Color.fromARGB(255, 203, 218, 244),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: Apie.getAllMessages(widget.user),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Center(
                          child: Text(
                        "Say Hi",
                        style: TextStyle(fontSize: 40),
                      ));

                    case ConnectionState.done:
                    case ConnectionState.active:
                      final data = snapshot.data!.docs;
                      // ('Data:${jsonEncode(data[0].data())}');
                      //list of messages
                      _list = data
                              ?.map((e) => Message.fromJson(e.data()))
                              .toList() ??
                          [];
                      //dummy message
                      if (_list.isNotEmpty) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            return MessageCaed(
                              message: _list[index],
                            );
                          },
                          itemCount: _list.length,
                        );
                      } else {
                        return Center(
                          child: Text("No connection"),
                        );
                      }
                  }

                  //switch
                }),
          ),
          Widget_chatInput()
        ],
      ),
    );
  }

  Widget_chatInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        Expanded(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.emoji_emotions,
                      color: Colors.blueAccent,
                    )),
                Expanded(
                    child: TextField(
                  controller: _textcontroller,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                      hintText: 'type something',
                      hintStyle: TextStyle(color: Colors.blueAccent),
                      border: InputBorder.none),
                )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.blueAccent,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.image,
                      color: Colors.blueAccent,
                    )),
              ],
            ),
          ),
        ),
        MaterialButton(
          padding: EdgeInsets.all(10),
          onPressed: () {
            if (_textcontroller.text.isNotEmpty) {
              Apie.sendMessage(widget.user, _textcontroller.text);
              _textcontroller == '';
            }
          },
          shape: CircleBorder(),
          color: Colors.green,
          child: const Icon(
            Icons.send,
            color: Color.fromARGB(255, 248, 245, 248),
            size: 25,
          ),
        )
      ]),
    );
  }
}
