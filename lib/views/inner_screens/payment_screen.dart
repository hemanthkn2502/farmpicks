import 'package:farmpicks/views/inner_screens/checkout_screen.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isPayOnDelivery=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Options',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Select payment method",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Pay on Delivery',
                  style: TextStyle(
                    fontSize: 18,
                  ),),

                  Switch(value: isPayOnDelivery, onChanged: (value){
                    setState(() {
                      isPayOnDelivery=value;
                    });

                    if(isPayOnDelivery)
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context)
                        {
                          return checkoutScreen();
                        }));
                      }
                  })

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
