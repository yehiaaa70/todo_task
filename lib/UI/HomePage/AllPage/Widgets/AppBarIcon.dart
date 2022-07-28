import 'package:flutter/material.dart';

class AppBarIcon extends StatelessWidget {
  const AppBarIcon(
      {Key? key, required this.icon, this.color, required this.onClick})
      : super(key: key);
  final IconData icon;
  final Color? color;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onClick,
        icon: Icon(
          icon,
          color: color ?? Colors.black,
        ));
  }
}
