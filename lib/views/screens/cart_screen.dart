import 'package:farmpicks/provider/cart_provider.dart';
import 'package:farmpicks/views/inner_screens/checkout_screen.dart';
import 'package:farmpicks/views/inner_screens/payment_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final _cartProvider= ref.read(cartProvider.notifier);
    final cartData=ref.watch(cartProvider);
    final totalAmount=ref.read(cartProvider.notifier).calculateTotalAmount();
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),),
        actions: [
          IconButton(onPressed: ()
          {
            _cartProvider.removeAllItems();
          }, icon:Icon(CupertinoIcons.delete ))
        ],
      ),
      body: cartData.isNotEmpty ? ListView.builder(
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
                          IconButton(onPressed: (){
                            _cartProvider.removeItem(cartItem.productId);

                          }, icon: Icon(CupertinoIcons.delete)),
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(onPressed: (){
                                    _cartProvider.decrementItem(cartItem.productId);

                                  }, icon: Icon(
                                    CupertinoIcons.minus,
                                        color: Colors.white,
                                  )),
                                  Text(cartItem.quantity.toString()+' '+cartItem.productSize,
                                  style: TextStyle(
                                    color: Colors.white
                                  ),),
                                  IconButton(onPressed: (){
                                    _cartProvider.incrementItem(cartItem.productId);

                                  }, icon: Icon(
                                      CupertinoIcons.plus,
                                    color: Colors.white,
                                  )),

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
      }):Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your Cart is empty',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),),
            Text("You haven't added any items to your Cart\n You can add from the home screen",
              textAlign: TextAlign.center,
              style:TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ) ,)
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Price' + ' \₹' + totalAmount.toStringAsFixed(2),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),),
              ElevatedButton(onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)
                 {
                   return PaymentScreen();
                 }));
              }, child: Text('Checkout'),
              )
            ],
          ),
        )
      ),

    );
  }
}