import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_assignment2/screens/login_screen.dart';
// import 'package:mobile_assignment2/screens/location_testing.dart';
import 'package:provider/provider.dart';

import 'helper/stores_db.dart';
import 'providers/StoreProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbHelper = DatabaseHelper.instance;

  await dbHelper.insertStore({
    'name': 'Nike',
    'address': 'Mall of Egypt',
    'isFavorite': 0,
  });

  await dbHelper.insertStore({
    'name': 'H&M',
    'address': 'City Stars',
    'isFavorite': 0,
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => ChangeNotifierProvider(
        create: (context) => StoreProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Store App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: LoginScreen(),
        ),
      ),
    );
  }
}
