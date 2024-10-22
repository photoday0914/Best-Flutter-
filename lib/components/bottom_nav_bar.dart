import 'dart:ffi';

import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;

  BottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
