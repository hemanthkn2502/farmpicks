import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmpicks/views/screens/widget/product_model.dart';
import 'package:flutter/material.dart';

class VegetablesProductImage extends StatelessWidget {

  // const HomeProductImage({super.key});

  final Stream<QuerySnapshot> _productsStream =
  FirebaseFirestore.instance.collection('products').where('category',isEqualTo:'Vegetables').where('discontinued',isEqualTo:false).snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Container(
          height: 100,
          child: PageView.builder(
              itemCount: snapshot.data!.docs.length,
              // final productData=
              itemBuilder: (context, index) {
                final productData = snapshot.data!.docs[index];
                return ProductModel(productData: productData);
              }),
        );
      },
    );
  }
}

