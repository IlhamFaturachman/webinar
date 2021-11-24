import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webinar_hit_api/Api/list_user_api.dart';
import 'package:webinar_hit_api/screen/screen2.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

Future<ListUser> fetchUser() async {
  final response =
      await http.get(Uri.parse("https://reqres.in/api/users?page=2"));

  if (response.statusCode == 200) {
    return ListUser.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Error To Access Endpoint");
  }
}

class _HomeState extends State<Home> {
  late Future<ListUser> listuser;
  @override
  void initState() {
    super.initState();
    listuser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: Container(
                height: 650,
                child: FutureBuilder<ListUser>(
                  future: listuser,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      final userData = snapshot.data.data;
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.perPage,
                          itemBuilder: (BuildContext context, int index) {
                            return Center(
                              child: Column(
                                children: [
                                  Container(
                                      width: 500,
                                      height: 100,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                            )
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          userData[index]
                                                              .avatar),
                                                      fit: BoxFit.cover)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Nama : " +
                                                      userData[index]
                                                          .firstName +
                                                      " " +
                                                      userData[index].lastName),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 5),
                                                    child: Text("Email : " +
                                                        userData[index].email),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                            );
                          });
                    } else {
                      return const Center(
                        child: Text("No data"),
                      );
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Screen2(),
                    ),
                  );
                },
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.grey)),
                    width: 100,
                    child: const Center(
                      child: Text("Next"),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
