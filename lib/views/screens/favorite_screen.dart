import 'package:farmpicks/provider/favorite_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({super.key});

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final _wishItem=ref.watch(favoriteProvider);
    final _favoriteProvider= ref.read(favoriteProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text('Wish List',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),),
        actions: [
          IconButton(onPressed: ()
              {
                 _favoriteProvider.removeAllItems();
              }, icon:Icon(CupertinoIcons.delete ))
        ],
      ),
      body: _wishItem.isNotEmpty ? ListView.builder(
        itemCount: _wishItem.length,
          itemBuilder: (context,index)
    {

      final wishData=_wishItem.values.toList()[index];
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: SizedBox(
            height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.network(wishData.imageUrl),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:50.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(wishData.productName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),),
                        Text('\₹ ' +wishData.price.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),),
                        IconButton(onPressed: (){
                          _favoriteProvider.removeItem(wishData.productId);

                        }, icon: Icon(Icons.cancel))
                      ],
                    ),
                  )
                ],
              ),
          ),
        ),
      );
    }  
      ): Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your wishlist is empty',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),),
            Text("You haven't added any items to your wishlist\n You can add from the home screen",
              textAlign: TextAlign.center,
                style:TextStyle(
                fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
              ) ,)
          ],
        ),
      ),
    );
  }
}
