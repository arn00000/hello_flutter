import 'package:flutter/material.dart';
import 'package:hello_flutter/service/auth_service.dart';
import 'package:hello_flutter/ui/navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isLoggedIn = await AuthService.isLoggedIn();
  runApp(MyApp(
    initialRoute: isLoggedIn ? "/home" : "/login",
  ));
}
