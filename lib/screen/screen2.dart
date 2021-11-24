import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webinar_hit_api/Api/post_api.dart';
import 'package:http/http.dart' as http;

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  _Screen2State createState() => _Screen2State();
}

Future<CreateUser> createUser(String name, String job) async {
  final response = await http.post(
    Uri.parse('https://reqres.in/api/users'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'name': name, 'job': job}),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return CreateUser.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

class _Screen2State extends State<Screen2> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _jobcontroller = TextEditingController();
  Future<CreateUser>? _postuserdata;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 200),
          child: Center(child: Container(child: (_postuserdata == null) ? nodata() : truesnapshotdata(),),),
        ),
      ),
    );
  }

  Column nodata() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _namecontroller,
          decoration: const InputDecoration(hintText: 'Enter Name'),
        ),
        TextField(
          controller: _jobcontroller,
          decoration: const InputDecoration(hintText: 'Enter Job'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _postuserdata =
                  createUser(_namecontroller.text, _jobcontroller.text);
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<CreateUser> truesnapshotdata() {
    return FutureBuilder<CreateUser>(
      future: _postuserdata,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Center(
                child: Container(
                  width: 300,
                  decoration:
                      const BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 2,
                      blurRadius: 2,
                    ),
                  ]),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Success"),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Screen2(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border.all(width: 2 , color: Colors.grey)
                              ),
                              child: Center(child: Text("OK")),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
