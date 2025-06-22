import 'package:flutter/material.dart';

class SetUp extends StatefulWidget {
  const SetUp({super.key});

  @override
  State<SetUp> createState() => _SetUp();
}

class _SetUp extends State<SetUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Text('SetUp'),
        ],
      ),
    );
  }
}