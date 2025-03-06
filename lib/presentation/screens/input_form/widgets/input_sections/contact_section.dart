import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_reorderable_grid_view/entities/order_update_entity.dart';
import 'package:flutter_reorderable_grid_view/widgets/widgets.dart';

import '../../../../../data/models/resume.dart';
import 'contact_entry.dart';

/// A widget that displays the contact information section as a reorderable grid.
class ContactSection extends StatelessWidget {
  /// Creates a new contact section widget.
  const ContactSection({
    required this.resume,
    required this.portrait,
    super.key,
  });

  /// The resume model containing the data.
  final Resume resume;

  /// Whether the layout is portrait or not.
  final bool portrait;

  @override
  Widget build(BuildContext context) {
    return ReorderableBuilder(
        longPressDelay: const Duration(milliseconds: 250),
        enableScrollingWhileDragging: false,
        // Styling for the widget being dragged.
        dragChildBoxDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black54,
              blurRadius: 10,
              offset: Offset(-2, 5),
            ),
          ],
        ),
        builder: (List<Widget> children) {
          return GridView.custom(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            childrenDelegate: SliverChildListDelegate(
              children,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 74,
              crossAxisCount: portrait ? 1 : 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
          );
        },
        // Generate the list of contact entry widgets.
        children: List<Widget>.generate(
          resume.contactList.length,
          (int index) => ContactEntry(
            key: UniqueKey(),
            contact: resume.contactList[index],
            onTextSubmitted: (String? value) {
              resume.rebuild();
            },
            onIconButtonPressed: () async {
              // Opens an icon picker when the icon button is pressed.
              final IconData? iconData = await FlutterIconPicker.showIconPicker(
                  context,
                  iconPackModes: <IconPack>[IconPack.cupertino]);
              if (iconData != null) {
                resume.contactList[index].iconData = iconData;
              }
              resume.rebuild();
            },
          ),
        ),
        // Handle the reordering callback.
        onReorder: (List<OrderUpdateEntity> orderUpdateEntities) {
          for (final OrderUpdateEntity element in orderUpdateEntities) {
            resume.onReorderContactInfoList(element.oldIndex, element.newIndex);
          }
        });
  }
} 