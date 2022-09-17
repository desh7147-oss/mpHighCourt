import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));
String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.status,
    this.msg,
    this.data,
  });

  LoginResponseModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? status;
  String? msg;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    this.id,
    this.name,
    this.email,
    this.number,
    this.role,
    this.token,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    number = json['number'];
    role = json['role'];
    token = json['token'];
  }
  String? id;
  String? name;
  String? email;
  String? number;
  String? role;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['number'] = number;
    map['role'] = role;
    map['token'] = token;
    return map;
  }
}
