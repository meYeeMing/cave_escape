import 'package:cave_escape/theme/app_styles.dart';
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

    logger.d('Open all Boxes');
    await Hive.openBox<StoryNodeModel>('nodeBox');
    await Hive.openBox<ImageMapping>('imageBox');
    await Hive.openBox<GameStateModel>('gameStateBox');
  } catch (e) {
    logger.e("error on initializing Hive or registering adapters : $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cave Escape',
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
          bodyLarge: TextStyle(color: AppColors.accentGold),
          bodyMedium: TextStyle(color: AppColors.accentGold),
          bodySmall: TextStyle(color: AppColors.accentGold),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
