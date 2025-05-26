import 'package:cave_escape/theme/app_colors.dart';
import 'package:cave_escape/utils/logger.dart';
import 'package:cave_escape/models/game_state_model.dart';
import 'package:cave_escape/models/image.dart';
import 'package:cave_escape/models/story_choice_model.dart';
import 'package:cave_escape/models/story_node_model.dart';
import 'package:cave_escape/screens/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //initial Hive
  try {
    if (kIsWeb) {
      // For web platform
      await Hive.initFlutter();
      logger.i('Hive initialized for Web successfully!');
    } else {
      // For native platforms
      final appDocumentDir = await getApplicationDocumentsDirectory();
      Hive.init(appDocumentDir.path);
      logger.i(
        'Hive initialized for Native platform successfully! Path: ${appDocumentDir.path}',
      );
    }

    // Register adapters
    Hive.registerAdapter(ImageMappingAdapter());
    Hive.registerAdapter(StoryNodeModelAdapter());
    Hive.registerAdapter(StoryChoiceModelAdapter());
    Hive.registerAdapter(GameStateModelAdapter());
    logger.i('Hive Adapters registered successfully!');
  } catch (e, stacktrace) {
    logger.e("error on initializing Hive or registering adapters : $e");
    logger.e('Stack Trace: $stacktrace');
  }

  // Register adapters

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cave Escape Text Games',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        scaffoldBackgroundColor: AppColors.background,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: AppColors.accentGold,
          ),
          bodyMedium: TextStyle(
            color: AppColors.accentGold,
          ),
          bodySmall: TextStyle(
            color: AppColors.accentGold,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(child: Container()),
    );
  }
}
