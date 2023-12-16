// class ChatUser {
//   ChatUser({
//     this.image3,
//     required this.roomPrice,
//     required this.image2,
//     required this.totalRoom,
//     required this.image1,
//     required this.description,
//     required this.userId,
//     required this.roomLocation,
//   });

//   late final Null image3;
//   late final String roomPrice;
//   late final String image2;
//   late final String totalRoom;
//   late final String image1;
//   late final String description;
//   late final String userId;
//   late final String roomLocation;

//   ChatUser.fromJson(Map<String, dynamic> json) {
//     image3 = null;
//     roomPrice = json['Room Price'];
//     image2 = json['Image2'];
//     totalRoom = json['Total Room'];
//     image1 = json['Image1'];
//     description = json['Discription'];
//     userId = json['userId'];
//     roomLocation = json['Room Location'];
//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['Image3'] = image3;
//     data['Room Price'] = roomPrice;
//     data['Image2'] = image2;
//     data['Total Room'] = totalRoom;
//     data['Image1'] = image1;
//     data['Discription'] = description;
//     data['userId'] = userId;
//     data['Room Location'] = roomLocation;
//     return data;
//   }
// }
