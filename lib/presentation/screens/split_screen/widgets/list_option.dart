import 'package:flutter/material.dart';

/// A list tile option for the drawer and popup menu
class ListOption extends StatelessWidget {
  final String title;
  final IconData iconData;
  final VoidCallback onTap;

  const ListOption({
    super.key,
    required this.title,
    required this.iconData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconData,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      title: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall,
      ),
      onTap: onTap,
    );
  }
}
