import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmpicks/views/inner_screens/product_detail_screen.dart';
import 'package:flutter/material.dart';

class CategoryProductScreen extends StatefulWidget {
  final dynamic categoryData;
  const CategoryProductScreen({super.key,required this.categoryData});

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance.collection('products').where('category',isEqualTo:widget.categoryData['categoryName']).where('discontinued',isEqualTo:false).snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryData['categoryName'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _productsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }


          if(snapshot.data!.docs.isEmpty)
            {
              return Center(
                child: Text('No Product under\n this category',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                ),),
              );
            }
          return GridView.builder(
            itemCount: snapshot.data!.size,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 200/300,
              ),
            itemBuilder: (context,index){
                final productData=snapshot.data!.docs[index];
                return Card(

                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder:(context)
                              {
                                return ProductDetailScreen(productData: productData);
                              }));
                        },
                        child: Container(
                          height: 150,
                          width: 300,
                            child: CachedNetworkImage(
                              //    fit: BoxFit.contain,
                              imageUrl: productData['imageUrlList'][0],
                              errorWidget: (context, url, error) => Text('Loading'),
                            ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(productData['productName'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: 300,
                        child: Text('₹'+ productData['productPrice'].toStringAsFixed(2)+' for 1'+productData['sizeList'][0],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),),
                      )
                    ],
                  ),
                );
            },
          );
        },
      )
    );
  }
}
