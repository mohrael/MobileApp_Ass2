import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:store_app/helper/db.dart';
import 'package:store_app/screens/storeList.dart';
import 'package:store_app/screens/add_to_favorite_screen.dart';
import 'providers/StoreProvider.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final dbHelper = DatabaseHelper.instance;

  await dbHelper.insertStore({
    'id':'1',
    'name': 'Zara',
    'address': 'Mall of Egypt',
    'isFavorite': 0,
  });

  await dbHelper.insertStore({
    'id':'2',
    'name': 'H&M',
    'address': 'City Stars',
    'isFavorite': 0,
  });

  runApp(ChangeNotifierProvider(
         create: (context) => StoreProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const StoreList(),          // Screen 1
          '/favorites': (context) =>const FavoriteStores(), // Screen 2
        },
      ),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StoreProvider(),
      child:MaterialApp(
        title: 'Store App',
       theme:ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StoreList(),
      ),
    );
  }
}



