import 'package:flutter/material.dart';
import 'package:mobile_assignment2/screens/add_to_favorite_screen.dart';
import 'package:provider/provider.dart';

import '../providers/StoreProvider.dart';

class StoreList extends StatefulWidget {
  const StoreList({super.key});

  @override
  State<StatefulWidget> createState() => StoreListScreen();
}

class StoreListScreen extends State<StoreList> {
  // bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<StoreProvider>(context);
    final provider = Provider.of<StoreProvider>(context);
    final stores = provider.stores;
    storeProvider.loadStores();
    // print(storeProvider.stores.length);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Stores'),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => FavoriteStores()));
              },
            )
          ],
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.blue,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 24,
          ),
        ),
        body: ListView.builder(
            itemCount: storeProvider.stores.length,
            itemBuilder: (context, index) {
              final store = stores[index];
              return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      leading: const Icon(
                        Icons.store,
                        color: Colors.blueAccent,
                      ),
                      //contentPadding: const EdgeInsets.all(10),
                      title: Text(
                        store['name'],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(store['address']),
                      trailing: IconButton(
                          onPressed: () {
                            // favorite
                            storeProvider.toggleFavorite(
                                store['id'], store['isFavorite'] == 0);
                            store['isFavorite'] == 1
                                ? ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            '${store['name']} has been removed from favorites')),
                                  )
                                : ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            '${store['name']} has been added to favorites')),
                                  );
                          },
                          icon: Icon(
                            store['isFavorite'] == 1
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: store['isFavorite'] == 1 ? Colors.red : null,
                          )),
                    ),
                  ));
            }));
  }
}
