import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/constants/app_colors.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/persistence/hive_data_store.dart';
import 'package:habit_tracker_flutter/ui/home/home_page.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppAssets.preloadSVGs();
  // Initialize Hive and register the Task adapter
  final dataStore = HiveDataStore();
  await dataStore.init();
  // Create demo tasks if the box is empty
  await dataStore.createDemoTasks(tasks: [
    Task.create(name: 'Wash Your Hands', iconName: AppAssets.washHands),
    Task.create(name: 'Wear a Mask', iconName: AppAssets.mask),
    Task.create(name: 'Brush Your Teeth', iconName: AppAssets.toothbrush),
    Task.create(name: 'Floss Your Teeth', iconName: AppAssets.dentalFloss),
    Task.create(name: 'Drink Water', iconName: AppAssets.water),
    Task.create(name: 'Practice Instrument', iconName: AppAssets.guitar),
  ], force: false);
  runApp(ProviderScope(overrides: [
    dataStoreProvider.overrideWithValue(dataStore),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Helvetica Neue',
      ),
      home: AppTheme(
        data: AppThemeData.defaultWithSwatch(AppColors.red),
        child: const HomePage(),
      ),
    );
  }
}
