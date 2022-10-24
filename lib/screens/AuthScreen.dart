import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rent_application/models/global.dart' as global;
import 'package:iconswitcher/iconswitcher.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    //print(global.isDarkModeEnable);
    bool left = true;
    double marginTop = 1.5;
    double height = kToolbarHeight - marginTop * 2;
    double width = height * 2;
    Duration duration = Duration(milliseconds: 400);
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconSwitcher(
              width: width,
              height: height,
              marginTop: marginTop,
              duration: duration,
              icon1: Icons.satellite,
              icon2: Icons.content_copy,
              color1: Colors.purple,
              color2: Colors.white,
              backgroundColor: Colors.black,
              firstIconSelectedColor: Colors.redAccent,
              secondIconSelectedColor: Colors.orangeAccent,
              onChange: (bool result) {
                setState(() {
                  left = result;
                  print('лево: $left');
                  global.isDarkModeEnable = result;
                  print('тема ${global.isDarkModeEnable}');
                });
              },
            )
          ],
        ),
        backgroundColor: global.isDarkModeEnable
            ? Theme.of(context).scaffoldBackgroundColor
            : Theme.of(context).scaffoldBackgroundColor,
        body: Column());
  }
}
