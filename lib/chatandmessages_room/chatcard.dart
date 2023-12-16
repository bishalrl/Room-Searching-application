import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:room_chha/chatandmessages_room/chatusermodeule.dart';
import 'package:room_chha/messege/messagepage.dart';

class ChatCard extends StatefulWidget {
  final ChatUser user;
  const ChatCard({super.key, required this.user});

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: const Color.fromARGB(255, 197, 213, 239),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Messenger(
                        user: widget.user,
                      )));
        },
        child: ListTile(
          title: Text(widget.user.name),
          leading: Icon(CupertinoIcons.person),
          subtitle: Text(
            'last message',
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
