import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmpicks/provider/favorite_provider.dart';
import 'package:farmpicks/views/inner_screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductModel extends ConsumerStatefulWidget {
  const ProductModel({super.key,required this.productData});

  final QueryDocumentSnapshot<Object?> productData;

  @override
  _ProductModelState createState() => _ProductModelState();
}

class _ProductModelState extends ConsumerState<ProductModel> {
  @override
  Widget build(BuildContext context) {
    final _favoriteProvider=ref.read(favoriteProvider.notifier);
    ref.watch(favoriteProvider);

    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ProductDetailScreen(productData: widget.productData,);
        }));
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 105,
              width: double.infinity,
              decoration: BoxDecoration(

                border: Border.all(color: Colors.white70),
                color: Colors.white30,
                boxShadow: [
                  BoxShadow(color: Color(0x0f000000)),
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 60,
                      width: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child:
                        Image.network(
                          widget.productData['imageUrlList'][0],
                          fit: BoxFit.contain,
                          height: 50,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(widget.productData['productName'],
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,


                              ),
                              softWrap: false,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text('\₹'+ widget.productData['productPrice'].toStringAsFixed(2)+' for 1'+widget.productData['sizeList'][0],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                            ),)
                        ],
                      ))
                ],
              ),
            ),
          ),
          Positioned(
            right: 15,
              top: 15,
              child: IconButton(
            onPressed: (){
              _favoriteProvider.addProductToFavorite(widget.productData['productName'], widget.productData['productId'], widget.productData['imageUrlList'][0], 1, widget.productData['productQuantity'], widget.productData['productPrice'], widget.productData['vendorId']);

            },
            icon: _favoriteProvider.getFavoriteItem.containsKey(widget.productData['productId'])?Icon(Icons.favorite,
            color: Colors.red,):Icon(Icons.favorite_border,color: Colors.red,),
          ))
        ],
      ),
    );
  }
}

