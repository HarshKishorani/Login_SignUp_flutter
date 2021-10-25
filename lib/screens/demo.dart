import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup_ui_starter/helper/auth.dart';
import 'package:login_signup_ui_starter/screens/loading.dart';

class Demo extends StatefulWidget {
  const Demo({Key key, this.user}) : super(key: key);

  final User user;

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  AuthMethods authMethods = new AuthMethods();
  User _user;

  @override
  void initState() {
    // TODO: implement initState
    _user = widget.user;
    print(_user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: _user.photoURL != null
                    ? Image.network(
                        _user.photoURL,
                      )
                    : Icon(
                        Icons.person,
                        size: 100,
                      ),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
              ),
              SizedBox(
                height: 25,
              ),
              Text("Hello, ${_user.displayName}"),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () {
                  authMethods.SignOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LandingPage()));
                },
                child: Text("SignOut"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
