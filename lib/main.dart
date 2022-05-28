import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ripple_animation/ui/views/home_view.dart';
import 'package:ripple_animation/viewmodels/home_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(

      create: (context) => HomeModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomeView(),
      ),
    );
  }
}
