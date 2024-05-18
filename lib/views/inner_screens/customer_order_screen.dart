import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomerOrderScreen extends StatefulWidget {
  const CustomerOrderScreen({super.key});

  @override
  State<CustomerOrderScreen> createState() => _CustomerOrderScreenState();
}

class _CustomerOrderScreenState extends State<CustomerOrderScreen> {
  final FirebaseAuth _auth =FirebaseAuth.instance;
  String formattedDate(date)
  {
    final outputDateFormat=DateFormat("dd/MM/yyyy");
    final outPutDate = outputDateFormat.format(date);

    return outPutDate;
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _ordersStream =
        FirebaseFirestore.instance.collection('orders').where('buyerId',isEqualTo: _auth.currentUser!.uid).snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _ordersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 14,
                      child:
                          data['accepted'] == true
                              ? Icon(Icons.delivery_dining)
                              : Icon(Icons.access_time),
                    ),
                    title: data['accepted'] == true
                        ? Text(
                            'Order Delivered and accepted',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.blue),
                          )
                        :  Text(
                                'Your order will be delivered',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.red),
                              ),
                    trailing: Text(
                      '\₹ ' + data['price'].toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ExpansionTile(
                    title: Text(
                      'Order Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.pink,
                      ),
                    ),
                    subtitle: Text(
                      'View Order Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.pink,
                      ),
                    ),
                    children: [
                      Row(children: [
                        Image.network(
                          data['productImage'],
                          height: 100,
                          width: 150,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:5.0),
                          child: Column(
                            children: [
                              Text(data['productName'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),),
                              Text(data['quantity'].toString()+data['measureType'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),),

                             Text(formattedDate(
                                 data['orderDate'].toDate(),
                             ),
                               style: TextStyle(
                                 fontSize: 18,
                                 fontWeight: FontWeight.bold,
                               ),
                             )
                            ],
                          ),
                        ),
                        Text('Received',
                        style: TextStyle(
                          color: Colors.white,
                        ),)
                      ])
                    ],
                  )
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
