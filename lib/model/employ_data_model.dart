// To parse this JSON data, do
//
//     final employDetails = employDetailsFromJson(jsonString);

import 'dart:convert';

EmployDetails employDetailsFromJson(String str) =>
    EmployDetails.fromJson(json.decode(str));

String employDetailsToJson(EmployDetails data) => json.encode(data.toJson());

class EmployDetails {
  EmployDetails(
      {required this.id,
      required this.name,
      required this.tittle,
      required this.date,
      this.toDate});

  String id;
  String name;
  String tittle;
  String date;
  String? toDate;
  factory EmployDetails.fromJson(Map<String, dynamic> json) => EmployDetails(
      id: json["id"],
      name: json["name"],
      tittle: json["tittle"],
      date: json["date"],
      toDate: json["toDate"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tittle": tittle,
        "date": date,
        "toDate": toDate
      };
}
