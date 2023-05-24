import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_flutter/ui/add.dart';
import 'package:hello_flutter/ui/design.dart';
import 'package:hello_flutter/ui/counter.dart';
import 'package:hello_flutter/ui/register.dart';

import 'canvas.dart';
import 'contact.dart';
import 'home.dart';
import 'home_tabs/tab3.dart';
import 'login.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.initialRoute}) : super(key: key);

  final String initialRoute;

  // final _router = GoRouter(initialLocation: "/", routes: [
  //   GoRoute(path: "/persons", builder: (context, state) => const Persons()),
  //   GoRoute(path: "/add", builder: (context, state) => const Add()),
  //   GoRoute(path: "/contacts", builder: (context, state) => const Contacts()),
  //   GoRoute(path: "/design", builder: (context, state) => const Design()),
  //   GoRoute(path: "/", builder: (context, state) => const Login()),
  //   GoRoute(
  //       path: "/home/:email",
  //       name: "home",
  //       builder: (context, state) => Home(email: state.pathParameters["email"] ?? ""))
  // ]);

  final _routes = [
    GoRoute(path: "/login", builder: (context,state)=> const Login()),
    GoRoute(path: "/add", builder: (context,state)=> const Add()),
    GoRoute(path: "/design", builder: (context,state)=> const Design()),
    GoRoute(path: "/contacts", builder: (context,state)=> const Contacts()),
    GoRoute(path: "/counter", builder: (context,state)=> const Counter()),
    GoRoute(path: "/home", builder: (context,state)=> const Home()),
    GoRoute(path: "/thirdTab", builder: (context,state)=> const ThirdTab()),
    GoRoute(path: "/register", builder: (context,state)=> const Register()),
    GoRoute(path: "/canvas", builder: (context,state)=> const MyCanvas()),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hello Flutter",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.grey),
      home: MaterialApp.router(
        routerConfig: GoRouter(
          initialLocation: initialRoute,
          routes: _routes
        ),
      ),
    );
  }
}
