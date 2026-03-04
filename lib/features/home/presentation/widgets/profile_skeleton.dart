import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surfaceContainer,
      highlightColor: Color.fromRGBO(72, 71, 92, 1),
      child: Container(
        width: 40,
        height: 40,
        decoration:  BoxDecoration(
          color:  Theme.of(context).colorScheme.surfaceContainer,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}