import 'dart:io';
import 'package:flutter/material.dart';
import '../model/stores.dart';
import 'package:provider/provider.dart';
import '../helper/db.dart';
class StoreProvider extends ChangeNotifier {
  // List<Store>_stores=[];
  // final List<Store> _stores = [
  //   Store(id: '1', name: 'Store A',address:'12 Street A'),
  //   Store(id: '2', name: 'Store B',address:'12 Street A'),
  //   Store(id: '3', name: 'Store C',address:'12 Street A'),
  // ];

  List<Map<String, dynamic>> _allStores = [];
  List<Map<String, dynamic>> _favoriteStores = [];
  List<Map<String, dynamic>> _nonFavoriteStores = [];
  
  List<Map<String,dynamic>>get stores => _allStores;
  List<Map<String, dynamic>> get nonFavorites => _nonFavoriteStores;
  List<Map<String, dynamic>> get favoriteStores => _favoriteStores;
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;


  Future<void> loadStores() async {
    _allStores = await _dbHelper.getAllStores();
    _nonFavoriteStores = await _dbHelper.getStoresWithFavoriteStatus(isFavorite: 0);
    notifyListeners();
  }

  Future<void> toggleFavorite(int storeId, bool isFavorite) async {
      await _dbHelper.toggleFavorite(storeId, isFavorite);
      loadStores(); // Reload the stores
  }
    // Add a new store
  Future<void> addStore(String name) async {
      await _dbHelper.insertStore({
        'name': name,
        'isFavorite': 0,
      });
      loadStores(); // Reload the stores
  }


  //elmfroud htb2a actual db 
  // Future<void> fetchStores()async{
  //   await Future.delayed(const Duration(seconds: 2));
  //   _stores = [
  //     Store( name: 'Tech Store' , address:'12 Street A'),
  //     Store( name: 'Store B',address:'16 Street B',isFavorite: true),
  //     Store( name: 'Store C',address:'14 Street C'),
  //     Store( name: 'Store D',address:'45 Street D'),
  //     Store( name: 'Store E',address:'20 Street E',isFavorite: true), 
  //   ];
    
      
  // }  
  
}
