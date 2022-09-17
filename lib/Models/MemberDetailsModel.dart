import 'dart:convert';

MemberDetailsModel memberDetailsModelFromJson(String str) =>
    MemberDetailsModel.fromJson(json.decode(str));
String memberDetailsModelToJson(MemberDetailsModel data) =>
    json.encode(data.toJson());

class MemberDetailsModel {
  MemberDetailsModel({
    this.status,
    this.user,
  });

  MemberDetailsModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['user'] != null) {
      user = [];
      json['user'].forEach((v) {
        user?.add(User.fromJson(v));
      });
    }
  }
  int? status;
  List<User>? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (user != null) {
      map['user'] = user?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.displayName,
    this.userNumber,
    this.userEmail,
    this.role,
    this.profileImg,
  });

  User.fromJson(dynamic json) {
    id = json['ID'];
    displayName = json['display_name'];
    userNumber = json['user_number'];
    userEmail = json['user_email'];
    role = json['Role'];
    profileImg = json['profile_img'];
  }
  String? id;
  String? displayName;
  String? userNumber;
  String? userEmail;
  String? role;
  String? profileImg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ID'] = id;
    map['display_name'] = displayName;
    map['user_number'] = userNumber;
    map['user_email'] = userEmail;
    map['Role'] = role;
    map['profile_img'] = profileImg;
    return map;
  }
}
