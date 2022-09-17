import 'dart:convert';

OccasionsModel occasionsModelFromJson(String str) =>
    OccasionsModel.fromJson(json.decode(str));
String occasionsModelToJson(OccasionsModel data) => json.encode(data.toJson());

class OccasionsModel {
  OccasionsModel({
    this.status,
    this.user,
  });

  OccasionsModel.fromJson(dynamic json) {
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
    this.occasion,
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    occasion = json['occasion'];
  }
  String? id;
  String? occasion;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['occasion'] = occasion;
    return map;
  }
}
