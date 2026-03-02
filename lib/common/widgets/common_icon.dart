import 'package:flutter/material.dart';

class CommonIcon extends StatelessWidget {
  final IconData icon;
  const CommonIcon({super.key,required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: Icon(
        icon,
        size: 20,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
