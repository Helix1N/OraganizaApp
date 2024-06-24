import 'package:flutter/material.dart';
import 'package:organiza_app/pages/signup.dart';
import 'package:organiza_app/pages/home.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  String? _userName;
  String? _password;

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    userNameController.addListener(_changeUserName);
    passwordController.addListener(_changePassword);
  }

  void _changeUserName() {
    setState(() {
      _userName = userNameController.text;
    });
  }

  void _changePassword() {
    setState(() {
      _password = passwordController.text;
    });
  }

  bool verifyUserAndPassword() {
    if (_userName != null && _password != null) {
      return true;
    }
    return false;
  }

  void postLoginData(BuildContext context) async {
    if (!verifyUserAndPassword()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Username or Password not set')),
      );
    } else {
      var url = Uri.parse(
          'http://10.0.2.3:8080/login'); // Replace with your API endpoint
      print(url);
      var response = await http
          .post(url, body: {"username": _userName, "password": _password});
      print(response);
      if (response.statusCode == 200) {
        // If server returns a 200 OK response, parse the JSON
        print(response.body); // Print the response body to the console
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              username: _userName!,
            ),
          ),
        );
      } else {
        // If the response was not OK, handle it accordingly
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Request failed')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(right: 390.0),
          child: Align(
              alignment: Alignment.topRight,
              child: Text(
                "Organize App",
                style: TextStyle(fontWeight: FontWeight.w700),
              )),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
              const Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "Get ready to organize yourself!",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextField(
                  controller: userNameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      hintText: "UserName/Email"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      hintText: "Password"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: GestureDetector(
                  onTap: () {
                    postLoginData(context);
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    height: 70,
                    alignment: Alignment.center,
                    child: const Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey)),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10),
                      child: Text("Or"),
                    ),
                    Expanded(
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey)),
                      ),
                    ),
                  ],
                ),
              ),
              /*Row(
                children: [
                  Container(
                    child: Image.asset(name),
                  ),
                  Container(child: Image.asset(name)),
                  Container(child: Image.asset())
                ],
              )*/
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Container(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Doesn't have an account? Sign up instead!",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}