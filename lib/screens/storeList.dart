import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/StoreProvider.dart';
import '../providers/StoreProvider.dart';

class StoreList extends StatefulWidget{
  const StoreList({super.key});

  @override
  State<StatefulWidget>createState() => StoreListScreen();
}

class StoreListScreen extends State<StoreList>{
 bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<StoreProvider>(context);
    final provider = Provider.of<StoreProvider>(context);
    final stores = provider.stores;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stores'),
        actions: [  
            IconButton(  
              icon:const Icon(Icons.favorite),    
              onPressed: () {    
                Navigator.pushNamed(context, '/favorites'); 
             },    )  ],
        centerTitle: true,   
        backgroundColor: Colors.blueAccent,
      ),

      body:
         ListView.builder(
              itemCount: storeProvider.stores.length,
              itemBuilder: (context, index){
                final store = stores[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      leading: const Icon(Icons.store,color: Colors.blueAccent,),
                      //contentPadding: const EdgeInsets.all(10),
                      title: Text(store['name'],
                      style: const TextStyle(
                        fontSize: 18,fontWeight: FontWeight.bold),),
                        subtitle: Text(store['address']),
                        trailing: IconButton(
                      onPressed:(){
                      // favorite
                        storeProvider.toggleFavorite(store['id'],store['isFavorite']==0);
                      } ,
                    icon: Icon(
                      store['isFavorite']? Icons.favorite:Icons.favorite_border,
                      color: store['isFavorite']?Colors.red:null,
                      )),
                    ) ,
                  )
              
                );
              }
         )
    );
  }        

}