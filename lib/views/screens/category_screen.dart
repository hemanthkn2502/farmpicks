import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmpicks/views/inner_screens/category_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {

  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _categoriesStream = FirebaseFirestore.instance.collection('Categories').snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.category),
            SizedBox(
              width: 5,
            ),
            Text('Categories',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),)
          ],
        ),
        centerTitle: true,
      ),
      body:  StreamBuilder<QuerySnapshot>(
      stream: _categoriesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
            itemCount: snapshot.data!.docs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8
              ),
              itemBuilder: (context,index)
              {
                final categoryData=snapshot.data!.docs[index];
                print(categoryData['categoryName']);
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CategoryProductScreen(categoryData: categoryData,);
                      }));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 4,
                            offset: Offset(0,2),
                          )
                        ]
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            //    fit: BoxFit.contain,
                            imageUrl: categoryData['image'],
                            errorWidget: (context, url, error) => Text('Loading'),
                          ),

                          Text(categoryData['categoryName'].toUpperCase(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),),

                        ],
                      ),
                    ),
                  );
              }
          ),
        );
      },
    ),
    );
  }
}

