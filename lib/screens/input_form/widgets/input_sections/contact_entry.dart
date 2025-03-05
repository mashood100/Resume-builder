import 'package:flutter/material.dart';

import '../../../../common/strings.dart';
import '../../../../models/contact.dart';
import '../../../../core/share-widgets/frosted_container.dart';
import '../../../../core/share-widgets/text_field/generic_text_field.dart';
import '../../../../core/share-widgets/icon_picker.dart';

/// A form field for a contact entry.
class ContactEntry extends StatelessWidget {
  const ContactEntry({
    super.key,
    required this.contact,
    required this.onTextSubmitted,
    required this.onIconButtonPressed,
  });

  /// The contact to use.
  final Contact contact;

  /// The callback when the user submits the text field.
  final Function(String?)? onTextSubmitted;

  /// The callback when the user presses the icon button.
  final Function()? onIconButtonPressed;

  @override
  Widget build(BuildContext context) {
    return FrostedContainer(
      child: Row(
        children: <Widget>[
          IconPicker(
            iconData: contact.iconData,
            onPressed: onIconButtonPressed,
          ),
          const SizedBox(width: 5),
          Expanded(
              child: GenericTextField(
            label: Strings.contact,
            controller: contact.textController,
            onSubmitted: onTextSubmitted,
          ))
        ],
      ),
    );
  }
}
