import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_application/screens/AuthScreen.dart';
import 'package:rent_application/theme/nativeTheme.dart';
import 'package:rent_application/theme/themeChanger.dart';
import 'package:rent_application/models/global.dart' as global;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => ThemeChanger(
                  nativeTheme(isDarkModeEnable: global.isDarkModeEnable))),
        ],
        child: MaterialAppWithTheme(),
      );
}

class MaterialAppWithTheme extends StatelessWidget {
  MaterialAppWithTheme();

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Управление гостями',
      //  navigatorObservers: <NavigatorObserver>[observer],
      theme: theme.getTheme,
      //ThemeData.dark(), //
      home: AuthScreen(),
    );
  }
}
