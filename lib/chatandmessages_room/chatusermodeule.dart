class ChatUser {
  ChatUser({
    required this.Email,
    required this.name,
    required this.userId,
    required this.friendUid,
  });
  late final String Email;
  late final String name;
  late final String userId;
  late final String friendUid;

  ChatUser.fromJson(Map<String, dynamic> json) {
    Email = json['Email'] ?? '';
    name = json['name'] ?? '';
    userId = json['userId'] ?? '';
    friendUid = json['friend_uid'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Email'] = Email;
    data['name'] = name;
    data['userId'] = userId;
    data['friend_uid'] = friendUid;
    return data;
  }
}
