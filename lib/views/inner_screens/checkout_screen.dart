import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../provider/cart_provider.dart';

class checkoutScreen extends ConsumerStatefulWidget {
  const checkoutScreen({super.key});

  @override
  _checkoutScreenState createState() => _checkoutScreenState();
}

class _checkoutScreenState extends ConsumerState<checkoutScreen> {
  bool _isloading = false;
  bool _initialscreen=false;
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore=FirebaseFirestore.instance;
    final FirebaseAuth _auth=FirebaseAuth.instance;
    final _cartProvider= ref.read(cartProvider.notifier);
    final cartData=ref.watch(cartProvider);
    final totalAmount=ref.read(cartProvider.notifier).calculateTotalAmount();
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: _initialscreen ? Container() : ListView.builder(
          shrinkWrap: true,
          itemCount: cartData.length,
          itemBuilder: (context,index)
          {
            final cartItem = cartData.values.toList()[index];

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
                        child: Image.network(cartItem.imageUrl),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:50.0),
                            child: Text(cartItem.productName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:10.0),
                                child: Text('\₹ ' +cartItem.price.toStringAsFixed(2) + ' per ' + cartItem.productSize,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink,
                                  ),),
                              ),

                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:15.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children:[
                                  Container(
                                    height: 40,
                                    width:180,
                                    decoration: BoxDecoration(
                                      color: Colors.pink,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        Text(cartItem.quantity.toString()+' '+cartItem.productSize,
                                          style: TextStyle(
                                              color: Colors.white
                                          ),),


                                      ],
                                    ),
                                  ),


                                ]
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),

      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () async{
            setState(() {
              _isloading=true;
            });
            DocumentSnapshot userDoc=await _firestore.collection('buyers').doc(_auth.currentUser!.uid).get();
            _cartProvider.getCartItems.forEach((key, item) async{
              final orderId= Uuid().v4();
              await _firestore.collection('orders').doc(orderId).set({
                'orderId': orderId,
                'productId':item.productId,
                'productName':item.productName,
                'quantity':item.quantity,
                'price': item.quantity * item.price,
                'fullName':(userDoc.data() as Map<String,dynamic>)['fullName'],
                'email':(userDoc.data() as Map<String,dynamic>)['email'],
                'buyerId':_auth.currentUser!.uid,
                'farmerId':item.vendorId,
                'totalQuantity':item.productQuantity,
                'productImage':item.imageUrl,
                'accepted':false,
                'orderDate':DateTime.now(),
                'measureType':item.productSize,

              }).whenComplete(() {
                setState(() {
                  _isloading=false;
                  _initialscreen=true;
                });
                final snackBar = SnackBar(
                  content: const Text('Your order has been placed successfullly',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),),
                  backgroundColor: (Colors.pink),
                  action: SnackBarAction(
                    label: 'okay',
                    onPressed: () {
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);


              });
            });
            _cartProvider.removeAllItems();

          },
          child:_initialscreen?Container(): Container(
            height: 50,
            width: MediaQuery.of(context).size.width-50,
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(9),
            ),
            child: //_isloading ? CircularProgressIndicator(
             // color: Colors.white,
           // ):
            Center(
              child: Text('Place order '+'\₹ '+ totalAmount.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),),
            ),
          ),
        ),
      ),
    );
  }
}
