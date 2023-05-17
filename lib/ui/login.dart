import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_flutter/service/auth_service.dart';

import '../data/model/user.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _email = "";
  var _pass = "";
  var _emailError = "";
  var _passError = "";

  _onClickRegister(){
    setState(() {
      context.push("/register");
    });
  }
  
  _onClickPerson(){
    setState(() {
      context.push("/persons");
    });
  }

  _onClickContact(){
    setState(() {
      context.push("/contacts");
    });
  }

  _onClickDesign(){
    setState(() {
      context.push("/design");
    });
  }

  _onEmailChanged(value) {
    setState(() {
      _email = value;
    });
  }

  _onPassChanged(value) {
    setState(() {
      _pass = value;
    });
  }

  _onClickLogin() {
    setState(() {
      if (_email.isEmpty) {
        _emailError = "Can't be empty";
        return;
      } else {
        _emailError = "";
      }

      if (_pass.isEmpty) {
        _passError = "Password can't be empty";
        return;
      } else {
        _passError = "";
      }
    });
    debugPrint("$_email,$_pass");
    // if (_email == "abc@gmail.com" && _pass == "qweqweqwe") {
    //   context.go("/home");
    //   AuthService.authenticate(
    //       User(name: _name, email: _email, password: _pass),
    //           (status) => {
    //         if (status)
    //           {context.go("/home")}
    //         else
    //           {debugPrint("wrong credential")}
    //       });
    // }
    AuthService.authenticate(_email, _pass, (status)=>{
        if (status)
          {context.go("/home")}
        else
          {debugPrint("wrong credential")}
    });

        // User(name: _name, email: _email, password: _pass),
        //     (status) => {
        //   if (status)
        //     {context.go("/home")}
        //   else
        //     {debugPrint("wrong credential")}
        // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello Flutter"),
        centerTitle: false,
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
              onPressed: () => debugPrint("Hello Scaffold"),
              icon: const Icon(
                Icons.sms,
                color: Colors.white,
                size: 32,
              )),
        ],
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.person, size: 200, color: Colors.grey),
        // Text("You entered $_email",
        //     textDirection: TextDirection.ltr,
        //     style:
        //         const TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0)),
        Container(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: TextField(
            onChanged: (value) => {_onEmailChanged(value)},
            decoration: InputDecoration(
                hintText: "Email",
                errorText: _emailError.isEmpty ? null : _emailError,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          child: TextField(
            onChanged: (value) => {_onPassChanged(value)},
            decoration: InputDecoration(
                hintText: "Password",
                errorText: _passError.isEmpty ? null : _passError,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          ),
        ),
        SizedBox(
          width: 350,
          height: 40,
          child: ElevatedButton(
            onPressed: () => _onClickLogin(),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text("Login"),
          ),
        ),
        SizedBox(
          width: 350,
          height: 40,
          child: ElevatedButton(
            onPressed: () => _onClickRegister(),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text("Register"),
          ),
        ),
        SizedBox(
          width: 350,
          height: 40,
          child: ElevatedButton(
            onPressed: () => _onClickPerson(),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text("person"),
          ),
        ),
        SizedBox(
          width: 350,
          height: 40,
          child: ElevatedButton(
            onPressed: () => _onClickContact(),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text("contact"),
          ),
        ),
        SizedBox(
          width: 350,
          height: 40,
          child: ElevatedButton(
            onPressed: () => _onClickDesign(),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text("contact"),
          ),
        ),
      ]),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => {},
      //   backgroundColor: Colors.cyan,
      //   child: const Icon(Icons.add),
      // )
    );
    // return Scaffold(
    //   body: Container(
    //     padding: const EdgeInsets.symmetric(horizontal: 30),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       crossAxisAlignment: CrossAxisAlignment.stretch,
    //       children: [
    //         const Text(
    //           'Welcome Back!',
    //           style: TextStyle(
    //             fontSize: 32,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //         const SizedBox(height: 40),
    //         const TextField(
    //           decoration: InputDecoration(
    //             labelText: 'Email',
    //           ),
    //         ),
    //         const SizedBox(height: 20),
    //         const TextField(
    //           obscureText: true,
    //           decoration: InputDecoration(
    //             labelText: 'Password',
    //           ),
    //         ),
    //         const SizedBox(height: 40),
    //         ElevatedButton(
    //           onPressed: () {},
    //           style: ElevatedButton.styleFrom(
    //             padding: const EdgeInsets.symmetric(vertical: 16),
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(30),
    //             ),
    //           ),
    //           child: const Text('Log In'),
    //         ),
    //         const SizedBox(height: 20),
    //         TextButton(
    //           onPressed: () {},
    //           child: const Text('Forgot Password?'),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
