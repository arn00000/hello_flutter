import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/model/user.dart';
import '../service/auth_service.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _Login2State();
}

class _Login2State extends State<Register> {
  var _email = "";
  var _emailError = "";
  var _password = "";
  var _passwordError = "";
  var _name = "";
  var _nameError = "";

  _onEmailChanged(value) {
    setState(() {
      _email = value;
    });
  }

  _onNameChanged(value) {
    setState(() {
      _name = value;
    });
  }

  _onPasswordChanged(value) {
    setState(() {
      _password = value;
    });
  }

  _onLoginClick() {
    setState(() {
      if (_email.isEmpty) {
        _emailError = "Can't be empty";
        return;
      } else {
        _emailError = "";
      }

      if (_name.isEmpty) {
        _nameError = "Name can't be empty";
        return;
      } else {
        _nameError = "";
      }

      if (_password.isEmpty) {
        _passwordError = "Password can't be empty";
        return;
      } else {
        _passwordError = "";
      }
    });
    AuthService.createUser(
        User(name: _name, email: _email, password: _password,));
    context.go("/login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Row(children: [
          Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "LOGIN",
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18.0),
              ))
        ]),
        Container(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: TextField(
              onChanged: (value) => {_onNameChanged(value)},
              decoration: InputDecoration(
                  hintText: "Name",
                  errorText: _nameError.isEmpty ? null : _nameError,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            )),
        Container(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: TextField(
              onChanged: (value) => {_onEmailChanged(value)},
              decoration: InputDecoration(
                  hintText: "Email",
                  errorText: _emailError.isEmpty ? null : _emailError,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            )),
        Container(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
            child: TextField(
                onChanged: (value) => {_onPasswordChanged(value)},
                decoration: InputDecoration(
                  hintText: "Password",
                  errorText: _passwordError.isEmpty ? null : _passwordError,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                obscureText: true)),
        ElevatedButton(
            onPressed: () => _onLoginClick(),
            style: const ButtonStyle(
                fixedSize: MaterialStatePropertyAll(Size.fromWidth(350))),
            child: const Text("Register")),
        ElevatedButton(
            onPressed: () => _onLoginClick(),
            style: const ButtonStyle(
                fixedSize: MaterialStatePropertyAll(Size.fromWidth(200))),
            child: const Text("Login"))
      ],
    ));
  }
}
