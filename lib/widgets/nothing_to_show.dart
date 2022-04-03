import 'package:flutter/material.dart';

class NothingToShow extends StatelessWidget {
  final String text;
  const NothingToShow(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      text,
      textAlign: TextAlign.center,
    ));
  }
}
