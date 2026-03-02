import 'package:flutter/material.dart';
import 'package:wechat/common/widgets/common_icon.dart';

class ProfileFeature extends StatelessWidget {
  final String featureName;
  final String featureDesc;
  final IconData icon;
  const ProfileFeature({
    super.key,
    required this.featureName,
    required this.featureDesc,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 25),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(featureName, style: Theme.of(context).textTheme.bodyMedium),

              Text(featureDesc, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          Spacer(),
          CommonIcon(icon: Icons.arrow_forward_ios_rounded),
        ],
      ),
    );
  }
}
