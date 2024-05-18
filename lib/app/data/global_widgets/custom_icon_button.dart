import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.color,
    required this.size,
  });

  final IconData icon;
  final void Function()? onPressed;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration:
          BoxDecoration(color: color.withOpacity(0.15), shape: BoxShape.circle),
      child: IconButton(
        icon: Icon(
          size: size,
          icon,
          color: color,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
