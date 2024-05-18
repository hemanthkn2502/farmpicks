import 'package:farmpicks/models/favorite_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteProvider = StateNotifierProvider<FavoriteNotifier,Map<String,FavoriteModel>>((ref) {
  return FavoriteNotifier();
},
);

class FavoriteNotifier extends StateNotifier<Map<String,FavoriteModel>>{
  FavoriteNotifier(): super({});




  void addProductToFavorite(
  String productName,
   String productId,
   String imageUrl,
  int quantity,
  int productQuantity,
   double price,
   String vendorId,
 //  String productSize,
  ){
   state[productId]= FavoriteModel(
      productName:productName,
      productId:productId,
      imageUrl:imageUrl,
      quantity:quantity,
      productQuantity:productQuantity,
      price:price,
       vendorId:vendorId,
 //    productSize:productSize,
    );
   // Notify listeners that the state has changed
   state={...state};
  }

  void removeAllItems(){
    state.clear();
    state={...state};
  }

  void removeItem(String productId)
  {
    state.remove(productId);
    state={...state};
  }

  Map<String,FavoriteModel> get getFavoriteItem => state;

}