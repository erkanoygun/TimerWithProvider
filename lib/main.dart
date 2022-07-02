import 'package:countdown_app/timerPage.dart';
import 'package:countdown_app/timerstate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyTimer()),
      ],
      child: MaterialApp(
        title: 'Timer',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TimerPage(),
      ),
    );
  }
}
