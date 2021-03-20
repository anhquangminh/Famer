import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/UserProvider.dart';
import 'screens/LoginPage.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider( // The providers that we are gonna use at the app
      providers: [
        ChangeNotifierProvider(
          create: (context) => User(),   // parentProvier
        ),

      ],
      child: MaterialApp(
        title: 'Farmer',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          accentColor: Colors.transparent,
        ),
        home: LoginPage(), // homepage

      ),
    );
  }
}
