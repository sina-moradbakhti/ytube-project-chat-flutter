import 'package:chatify/constants/text_styles.dart';
import 'package:chatify/pages/login/view.dart';
import 'package:chatify/pages/messages/view.dart';
import 'package:chatify/pages/register/view.dart';
import 'package:chatify/pages/welcome/view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: 'Nexa',
          scaffoldBackgroundColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(8)),
              focusColor: Colors.black,
              iconColor: Colors.grey,
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(8)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          appBarTheme: const AppBarTheme(
              toolbarHeight: 69,
              color: Colors.white,
              iconTheme: IconThemeData(color: Colors.black, size: 24),
              elevation: 0,
              centerTitle: true,
              titleTextStyle: MyTextStyles.appbar)),
      home: const Welcome(),
    );
  }
}
