import 'package:flutter/material.dart';
import '../../../../common/strings.dart';

/// A tab bar for switching between the input form and the PDF viewer
class CustomTabBar extends StatelessWidget {
  final TabController controller;

  const CustomTabBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorSize: TabBarIndicatorSize.tab,
      controller: controller,
      tabs: const <Widget>[
        Tab(
          text: Strings.form,
        ),
        Tab(
          text: Strings.preview,
        ),
      ],
    );
  }
}
