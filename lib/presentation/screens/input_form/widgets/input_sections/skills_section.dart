import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/entities/order_update_entity.dart';
import 'package:flutter_reorderable_grid_view/widgets/widgets.dart';

import '../../../../../common/strings.dart';
import '../../../../../data/models/resume.dart';
import '../../../../../core/share-widgets/frosted_container.dart';
import '../section_title.dart';

/// A widget that displays the skills section with a reorderable grid.
class SkillsSection extends StatelessWidget {
  /// Creates a new skills section widget.
  const SkillsSection({
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
    return Column(
      children: <Widget>[
        // Section title with add button and visibility toggle.
        SectionTitle(
          title: Strings.skills,
          resume: resume,
          allowVisibilityToggle: true,
          onAddPressed: resume.addSkill,
        ),
        // The skills list is displayed with reduced opacity if the section is hidden.
        Opacity(
          opacity: resume.sectionVisible(Strings.skills) ? 1 : 0.5,
          child: ReorderableBuilder(
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
            onReorder: (List<OrderUpdateEntity> orderUpdateEntities) {
              // Update the order of skills.
              for (final OrderUpdateEntity element in orderUpdateEntities) {
                resume.onReorderSkillsList(element.oldIndex, element.newIndex);
              }
            },
            builder: (List<Widget> children) {
              return GridView.custom(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childrenDelegate: SliverChildListDelegate(children),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 74,
                  crossAxisCount: portrait ? 2 : 5,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
              );
            },
            // Generate each skill text field inside a frosted container.
            children: List<Widget>.generate(
              resume.skillTextControllers.length,
              (int index) => FrostedContainer(
                key: UniqueKey(),
                child: TextFormField(
                  controller: resume.skillTextControllers[index],
                  enabled: resume.sectionVisible(Strings.skills),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onFieldSubmitted: (String value) {
                    resume.rebuild();
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
} 