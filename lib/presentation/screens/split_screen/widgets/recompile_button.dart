import 'package:flutter/material.dart';
import '../../../../common/strings.dart';

/// Button to save and recompile the resume
class RecompileButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const RecompileButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: Strings.recompileShortCut,
      child: MaterialButton(
        color: Colors.green[700]!.withOpacity(0.9),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: onPressed ?? () {},
        minWidth: 25,
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(
              Icons.sync,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 4),
            Text(
              Strings.recompile.toUpperCase(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}
