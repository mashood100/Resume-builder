import 'package:flutter/material.dart';
import '../../../../common/strings.dart';

class AuthHeader extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String? subtitle;
  final bool showLogo;
  final double? iconSize;
  final double? logoHeight;

  const AuthHeader({
    Key? key,
    this.icon,
    required this.title,
    this.subtitle,
    this.showLogo = true,
    this.iconSize = 64,
    this.logoHeight = 80,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showLogo)
          Image.asset(
            Strings.iconPath,
            height: logoHeight,
          ),
        if (icon != null) ...[
          Icon(
            icon,
            size: iconSize,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
        ],
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
} 