import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DemandScreen extends StatefulWidget {
  const DemandScreen({super.key});

  @override
  State<DemandScreen> createState() => _DemandScreenState();
}

class _DemandScreenState extends State<DemandScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore=FirebaseFirestore.instance;
    final Stream<QuerySnapshot> _demandStream =
    FirebaseFirestore.instance.collection('demands').where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demands'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _demandStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final demandData = snapshot.data!.docs[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          demandData['productName'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          '\₹ ' + demandData['price'].toString() + ' per ' + demandData['quantityMeasure'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                        Text(
                          'Required: ' + demandData['quantityRequired'].toString() + ' ' + demandData['quantityMeasure'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                        Text(
                          'Deliver by: ' + demandData['deliverBy'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                        Text(
                          'Phone Number: ' + demandData['phoneNumber'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                        Text(
                          'Delivery Location: ' + demandData['deliveryLocation'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {

                              },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, // Change button color
                              foregroundColor: Colors.white, // Change text color
                              elevation: 4, // Add elevation
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Adjust padding
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8), // Adjust border radius
                              ),
                            ),
                            child: demandData['accepted']==true ?Text('Accepted')
                                :Text('Not yet accepted'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
