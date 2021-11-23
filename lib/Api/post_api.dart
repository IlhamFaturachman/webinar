// To parse this JSON data, do
//
//     final createUser = createUserFromJson(jsonString);

import 'dart:convert';

CreateUser createUserFromJson(String str) => CreateUser.fromJson(json.decode(str));

String createUserToJson(CreateUser data) => json.encode(data.toJson());

class CreateUser {
    CreateUser({
        required this.name,
        required this.job,
        required this.id,
        required this.createdAt,
    });

    String name;
    String job;
    String id;
    DateTime createdAt;

    factory CreateUser.fromJson(Map<String, dynamic> json) => CreateUser(
        name: json["name"],
        job: json["job"],
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "job": job,
        "id": id,
        "createdAt": createdAt.toIso8601String(),
    };
}
