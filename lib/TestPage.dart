import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        children: [
          Expanded(child: Container()),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Expanded(
                    child: Container(
                  child: Row(
                    children: [
                      Expanded(child: Container()),

                      
                      Expanded(child: Container()),
                    ],
                  ),
                )),
                Expanded(
                    flex: 4,
                    child: Container(
                      color: Colors.white,
                    )),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
