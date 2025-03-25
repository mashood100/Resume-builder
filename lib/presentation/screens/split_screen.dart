import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../common/sample_resume.dart';
import '../../common/strings.dart';
import '../../data/models/resume.dart';
import '../../services/pdf_generator.dart';
import '../../services/project_info.dart';
import 'split_screen/managers/split_screen_manager.dart';
import 'split_screen/widgets/portrait_layout.dart';
import 'split_screen/widgets/landscape_layout.dart';
import 'split_screen/widgets/custom_tab_bar.dart';
import 'split_screen/widgets/theme_toggle_button.dart';
import 'input_form/widgets/portrait_drawer.dart';

/// Split view of the resume builder (input form and PDF viewer).
class SplitScreen extends StatefulWidget {
  const SplitScreen({super.key});
  @override
  State<StatefulWidget> createState() => SplitScreenState();
}

class SplitScreenState extends State<SplitScreen>
    with TickerProviderStateMixin {
  /// The resume to use.
  Resume _resume = SampleResume();

  /// The project info handler.
  ProjectVersionInfoHandler projectInfoHandler = ProjectVersionInfoHandler();

  /// The PDF generator.
  late PDFGenerator pdfGenerator;

  /// The tab controller.
  TabController? _tabController;

  /// The form scroll controller.
  final ScrollController _formScrollController = ScrollController();

  /// The split screen manager.
  late SplitScreenManager _manager;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    pdfGenerator = PDFGenerator(resume: _resume);
    _initializeManager();
  }

  /// Initialize the split screen manager.
  void _initializeManager() {
    _manager = SplitScreenManager(
      resume: _resume,
      pdfGenerator: pdfGenerator,
      projectInfoHandler: projectInfoHandler,
      formScrollController: _formScrollController,
      onStateChanged: _handleStateChanged,
    );
  }

  /// Handle state changes from the manager.
  void _handleStateChanged() {
    setState(() {
      _resume = Resume();
      pdfGenerator = PDFGenerator(resume: _resume);
      _formScrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: ChangeNotifierProvider<Resume>.value(
        value: _resume,
        child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return Scaffold(
              drawer: orientation == Orientation.landscape
                  ? null
                  : PortraitDrawer(
                      pdfGenerator: pdfGenerator,
                      actionItems: _manager.getDrawerActionItems(context),
                      projectVersionInfoHandler: projectInfoHandler,
                    ),
              appBar: AppBar(
                bottom: orientation == Orientation.landscape
                    ? null
                    : PreferredSize(
                        preferredSize: const Size.fromHeight(48),
                        child: CustomTabBar(controller: _tabController!),
                      ),
                title: Row(
                  children: <Widget>[
                    const Text(Strings.resumeBuilder),
                    if (orientation == Orientation.landscape) const Spacer(),
                    if (orientation == Orientation.portrait)
                      IconButton(
                        icon: const Icon(Icons.restart_alt),
                        tooltip: Strings.clearResume,
                        onPressed: () =>
                            _manager.handleDestinationSelected(context, 0),
                      ),
                    if (orientation == Orientation.portrait)
                      IconButton(
                        icon: const Icon(Icons.upload_file),
                        tooltip: Strings.importJson,
                        onPressed: () =>
                            _manager.handleDestinationSelected(context, 1),
                      ),
                    if (orientation == Orientation.portrait)
                      IconButton(
                        icon: const Icon(Icons.download),
                        tooltip: Strings.downloadPdfAndJson,
                        onPressed: () =>
                            _manager.handleDestinationSelected(context, 2),
                      ),
                    if (orientation == Orientation.portrait)
                      const ThemeToggleButton(),
                  ],
                ),
                actions: [
                  if (orientation == Orientation.landscape)
                    const ThemeToggleButton(),
                ],
                centerTitle: false,
              ),
              body: Consumer<Resume>(
                builder: (BuildContext context, Resume resume, Widget? child) {
                  return Shortcuts(
                    shortcuts: <ShortcutActivator, Intent>{
                      LogicalKeySet(LogicalKeyboardKey.meta,
                          LogicalKeyboardKey.enter): const RecompileIntent(),
                    },
                    child: Actions(
                      actions: <Type, Action<Intent>>{
                        RecompileIntent: CallbackAction<RecompileIntent>(
                          onInvoke: (RecompileIntent intent) => setState(() {
                            _resume.formKey.currentState!.saveAndValidate();
                          }),
                        ),
                      },
                      child: orientation == Orientation.portrait
                          ? PortraitLayout(
                              tabController: _tabController!,
                              formScrollController: _formScrollController,
                              pdfGenerator: pdfGenerator,
                            )
                          : LandscapeLayout(
                              formScrollController: _formScrollController,
                              pdfGenerator: pdfGenerator,
                              onDestinationSelected: (index) => _manager
                                  .handleDestinationSelected(context, index),
                              onRecompile: _manager.handleRecompile,
                            ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

/// The intent to recompile the resume.
class RecompileIntent extends Intent {
  const RecompileIntent();
}
