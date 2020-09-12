// To parse this JSON data, do
//
//     final resultNews = resultNewsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ResultNews resultNewsFromJson(String str) => ResultNews.fromJson(json.decode(str));

String resultNewsToJson(ResultNews data) => json.encode(data.toJson());

class ResultNews {
  ResultNews({
    @required this.message,
    @required this.status,
    @required this.data,
  });

  String message;
  int status;
  List<Datum> data;

  factory ResultNews.fromJson(Map<String, dynamic> json) => ResultNews(
    message: json["message"],
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    @required this.idUser,
    @required this.fullnameUser,
    @required this.emailUser,
    @required this.phoneUser,
    @required this.photoUser,
    @required this.usernameUser,
    @required this.passwordUser,
    @required this.idRole,
  });

  String idUser;
  String fullnameUser;
  String emailUser;
  String phoneUser;
  String photoUser;
  String usernameUser;
  String passwordUser;
  String idRole;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    idUser: json["id_user"],
    fullnameUser: json["fullname_user"],
    emailUser: json["email_user"],
    phoneUser: json["phone_user"],
    photoUser: json["photo_user"],
    usernameUser: json["username_user"],
    passwordUser: json["password_user"],
    idRole: json["id_role"],
  );

  Map<String, dynamic> toJson() => {
    "id_user": idUser,
    "fullname_user": fullnameUser,
    "email_user": emailUser,
    "phone_user": phoneUser,
    "photo_user": photoUser,
    "username_user": usernameUser,
    "password_user": passwordUser,
    "id_role": idRole,
  };
}
