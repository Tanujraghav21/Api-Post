import 'package:api2/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(ApiCall());
}

class ApiCall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Create User",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

Future<UserModel?> createUser(String name, String job) async {
  final String url = "https://reqres.in/api/users";

  final response =
      await http.post(Uri.parse(url), body: {"name": name, "job": job});

  if (response.statusCode == 201) {
    final String stringresponse = response.body;
    return userModelFromJson(stringresponse);
  } else {
    return null;
  }
}

class _HomePageState extends State<HomePage> {
  UserModel? _users;
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController jobcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Text("Create User"),
      ),
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 10,
                      ),
                    ),
                    labelText: "Name",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: jobcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 10),
                      ),
                      labelText: "Technology"),
                ),
                SizedBox(
                  height: 32,
                ),
                _users == null
                    ? Container()
                    : Text(
                        "The user ${_users!.name} is Having id ${_users!.id} is  sucessful created at  ${_users!.createdAt.toIso8601String()}")
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        onPressed: () async {
          final String name = namecontroller.text;
          final String job = jobcontroller.text;
          final UserModel? user = await createUser(name, job);
          setState(() {
            _users = user;
          });
        },
        tooltip: "Add",
        child: Icon(Icons.add),
      ),
    );
  }
}
