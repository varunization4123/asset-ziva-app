class UserModel {
  String name;
  String email;
  // String bio;
  String profilePic;
  // String createdAt;
  String phoneNumber;
  String uid;
  var services;
  String gst;

  UserModel({
    required this.name,
    required this.email,
    // required this.bio,
    required this.profilePic,
    // required this.createdAt,
    required this.phoneNumber,
    required this.uid,
    required this.gst,
    required this.services,
  });

  // from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      // bio: map['bio'] ?? '',
      uid: map['uid'] ?? '',
      gst: map['gst'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      // createdAt: map['createdAt'] ?? '',
      profilePic: map['profilePic'] ?? '',
      services: map['services'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "uid": uid,
      "gst": gst,
      // "bio": bio,
      "profilePic": profilePic,
      "phoneNumber": phoneNumber,
      // "createdAt": createdAt,
      "services": services,
    };
  }
}
