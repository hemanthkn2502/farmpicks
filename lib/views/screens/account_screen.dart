

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmpicks/views/inner_screens/customer_order_screen.dart';
import 'package:farmpicks/views/inner_screens/demand_screen.dart';
import 'package:farmpicks/views/screens/cart_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'auth/loginscreen.dart';

class AccountScreen extends StatelessWidget {
 final FirebaseAuth _auth= FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile',
      style: TextStyle(
          fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.sunny,
    color: Colors.pink,),
      ),
    ],
      ),

    body: SingleChildScrollView(
      child: FutureBuilder<DocumentSnapshot>(
        future: users.doc(_auth.currentUser!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(data['fullName'].toUpperCase(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(data['email'],
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),




                  ListTile(
                    leading: Icon(
                      Icons.phone,
                    ),
                    title: Text(
                      'Phone',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text('9999999999'),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)
                      {
                        return CartScreen();
                      }));
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.shopping_cart,
                      ),
                      title: Text(
                        'Cart',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context)
                      {
                        return CustomerOrderScreen();
                      }));
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.shopping_bag,
                      ),
                      title: Text(
                        'Orders',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context)
                      {
                        return DemandScreen();
                      }));
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.business_center,
                      ),
                      title: Text(
                        'Demands',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: ()async{
                     await _auth.signOut().whenComplete((){
                       return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                         return LoginScreen();
                       }));
                     });
                    },
                    leading: Icon(
                      Icons.logout,
                    ),
                    title: Text(
                      'Log out',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                  ),


                ],
              ),
            );

              }

          return Center(
            child: CircularProgressIndicator(

            ),
          );
        },

      ),
    )
      );
  }
}
