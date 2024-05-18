import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmpicks/views/screens/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CategoryTextWidget extends StatefulWidget {
  const CategoryTextWidget({super.key});

  @override
  State<CategoryTextWidget> createState() => _CategoryTextWidgetState();
}

class _CategoryTextWidgetState extends State<CategoryTextWidget> {
  final Stream<QuerySnapshot> _categoriesStream =
      FirebaseFirestore.instance.collection('Categories').snapshots();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _categoriesStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading categories");
              }

              return Container(
                height: 55,
                  child: Row(
                    children: [
                      Expanded(child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context,index){
                            final categoryData=snapshot.data!.docs[index];
                            return Padding(
                              padding: const EdgeInsets.only(right:8.0,top: 8.0),
                              child: ActionChip(
                                onPressed: (){

                                },
                                backgroundColor: Colors.pink,
                                  label: Center(
                                   child: Center(
                                     child: Text(categoryData['categoryName'],
                                     style: TextStyle(
                                       color: Colors.white,
                                       fontWeight: FontWeight.bold,
                                       fontSize: 17,
                                     ),),
                                   )
                                  )),
                            );
                          })),
                      IconButton(onPressed: (){
                            Get.to(CategoryScreen());
                      }, icon:Icon( Icons.arrow_forward_outlined)
                      ),
                    ],
                  ),
              );
            },
          ),
        ],
      ),
    );
  }
}
