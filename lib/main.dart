/*
There is also the alternative of using an InheritedWidget instead of a StatefulWidget;
this is particularly useful if you want your child widgets to rebuild
if the parent widget's data changes and the parent isn't a direct parent.
 */

import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        builder: (context, child) =>
            SafeArea(child: Material(color: Colors.white, child: child)),
        home: const MainPage(),
      ),
    );

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();

  // if type _MainPageState is added, lint warning
  static of(BuildContext context) =>
      context.findAncestorStateOfType<_MainPageState>()!;
}

class _MainPageState extends State<MainPage> {
  String _string = "Not set yet";

  set string(String value) => setState(() => _string = value);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(_string),
        MyChildClass(callback: (val) => setState(() => _string = val))
      ],
    );
  }
}

typedef StringCallback = void Function(String val);

class MyChildClass extends StatelessWidget {
  final StringCallback callback;

  const MyChildClass({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextButton(
          onPressed: () {
            callback("String from method 1");
          },
          child: const Text("Method 1"),
        ),
        TextButton(
          onPressed: () {
            MainPage.of(context).string = "String from method 2";
          },
          child: const Text("Method 2"),
        )
      ],
    );
  }
}
