import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/StoreProvider.dart';
import '../providers/StoreProvider.dart';
import '../model/stores.dart';


class FavoriteStores extends StatefulWidget{
  const FavoriteStores({super.key});

  @override
  State<StatefulWidget>createState() => FavoriteStoresScreen();


}

class FavoriteStoresScreen extends State<FavoriteStores>{
  // const AddToFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) { 
      final provider = Provider.of<StoreProvider>(context);
      final nonFavorites = provider.nonFavorites;
  
  
   return Scaffold(
    appBar:AppBar( 
      title: const Text("Add Store to Favorites"),
        centerTitle: true,   
        backgroundColor: Colors.blueAccent,
      ),
      
    body:
     nonFavorites.isEmpty
    ?const Center(child: Text("All Stores are already favourite!"),)
    :
    ListView.builder(
      itemCount: nonFavorites.length,
      itemBuilder: (context,index){
      final store = nonFavorites[index];
      return Padding(
        padding:const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          ),
          child: 
          ListTile(
        title: Text(store['name']),
        subtitle: Text(store['address']),
        trailing: IconButton(
          onPressed:(){
            provider.toggleFavorite(store['id'],true);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${store['name']} added to favorites')),
            );
            
          } , 
          icon:const Icon(Icons.favorite_border),
          ),
          )
        ),
          );
      } )      

   );
  }
}