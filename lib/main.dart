import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/firebase_options.dart';
import 'package:hello_flutter/provider/counter_provider.dart';
import 'package:hello_flutter/service/auth_service.dart';
import 'package:hello_flutter/ui/navigation.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final isLoggedIn = await AuthService.isLoggedIn();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => CounterProvider())],
    child: MyApp(
      initialRoute: isLoggedIn ? "/home" : "/login",
    ),
  ));
}
