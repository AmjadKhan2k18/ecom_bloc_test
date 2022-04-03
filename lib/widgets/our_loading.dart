import 'package:flutter/material.dart';

class OurLoading extends StatelessWidget {
  const OurLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
