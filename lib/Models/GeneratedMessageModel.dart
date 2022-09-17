class GeneratedMessageModel {
  GeneratedMessageModel({
    this.status,
    this.user,
  });

  GeneratedMessageModel.fromJson(dynamic json) {
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

class User {
  User({
    this.temp,
  });

  User.fromJson(dynamic json) {
    temp = json['temp'];
  }
  String? temp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['temp'] = temp;
    return map;
  }
}
