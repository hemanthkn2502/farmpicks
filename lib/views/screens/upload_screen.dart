import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmpicks/views/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  final GlobalKey<FormState> _key=GlobalKey<FormState>();
  late String name;
  late String productName;
  late String quantityMeasure;
  late int quantityRequired;
  late int price;
  late String deliveryLocation;
  late String deliverBy;
  late String phoneNumber;
  late String email;
  final nameText = TextEditingController();
  final productNameText = TextEditingController();
  final quantityMeasureText = TextEditingController();
  final quantityRequiredText = TextEditingController();
  final productPriceText = TextEditingController();
  final deliveryLocationText = TextEditingController();
  final phoneNumberText=TextEditingController();
  final emailText=TextEditingController();

  String date='Selected date';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Upload Demand'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'Please fill name';
                    }
                    else
                    {
                      return null;
                    }
                  },
                  onChanged: (value)
                  {
                    name=value;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Name',
                      hintText: 'Name',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                  controller: nameText,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'Please fill Email Address';
                    }
                    else
                    {
                      return null;
                    }
                  },
                  onChanged: (value)
                  {
                    email=value;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Email Address',
                      hintText: 'Email Address',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,

                      )
                  ),
                  controller: emailText,

                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'Please fill product name';
                    }
                    else
                    {
                      return null;
                    }
                  },
                  onChanged: (value)
                  {
                    productName=value;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Product Name',
                      hintText: 'Product Name',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,

                      )
                  ),
                  controller: productNameText,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'Please fill quantity measure';
                    }
                    else
                    {
                      return null;
                    }
                  },
                  onChanged: (value)
                  {
                    quantityMeasure=value;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Quantity Measure',
                      hintText: 'Quantity Measure',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,

                      )
                  ),
                  controller: quantityMeasureText,

                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'Please fill quantity required';
                    }
                    else
                    {
                      return null;
                    }
                  },
                  onChanged: (value)
                  {
                    quantityRequired=int.parse(value);
                    print(quantityRequired);
                  },
                  decoration: const InputDecoration(
                      labelText: 'Quantity Required',
                      hintText: 'Quantity Required (Please only write number)',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,

                      )
                  ),
                  controller: quantityRequiredText,

                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'Please fill price';
                    }
                    else
                    {
                      return null;
                    }
                  },
                  onChanged: (value)
                  {
                    price=int.parse(value);
                  },
                  decoration: const InputDecoration(
                      labelText: 'Product Price',
                      hintText: 'Product Price',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,

                      )
                  ),
                  controller: productPriceText,

                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  minLines: 1,
                  validator: (value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'Please fill Delivery Location';
                    }
                    else
                    {
                      return null;
                    }
                  },
                  onChanged: (value)
                  {
                    deliveryLocation=value;
                  },
                  decoration: const InputDecoration(

                      labelText: 'Delivery Location',
                      hintText: 'Delivery Location',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,

                      )

                  ),
                  controller: deliveryLocationText,

                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'Please fill phone number';
                    }
                    else
                    {
                      return null;
                    }
                  },
                  onChanged: (value)
                  {
                    phoneNumber=value;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Phone number',
                      hintText: 'Phone number',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                  controller: phoneNumberText,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('Select the date before which product must be delivered',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
                SizedBox(
                  height: 200,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (DateTime newDateTime) {
                      setState(() {
                        deliverBy=newDateTime.toString();
                        date=deliverBy.substring(0,10);
                      });
                        if(deliverBy!=null) {
                          deliverBy.trim();
                          print(deliverBy);
                        }
                      // Do something
                    },
                  ),
                ),
               Text(date,
                 style: TextStyle(
                   fontSize: 18,
                   fontWeight: FontWeight.bold,
                 ),
               ),
                const SizedBox(
                  height: 20,
                ),
                //Image.network('https://www.daysoftheyear.com/cdn-cgi/image/dpr=1%2Cf=auto%2Cfit=cover%2Cheight=650%2Cq=40%2Csharpen=1%2Cwidth=956/wp-content/uploads/fresh-fruits-and-vegetables-2021-08-26-17-06-09-utc.jpg'),
                ElevatedButton(
                    onPressed: () async
                    {
                      if(_key.currentState!.validate())
                        {
                          EasyLoading.show(status: 'Please wait');
                          var demandId=Uuid().v4();
                          await _firestore.collection('demands').doc(demandId)
                          .set(
                            {
                              'demandId':demandId,
                              'name':name,
                              'email':email,
                              'userId':FirebaseAuth.instance.currentUser!.uid,
                            'productName':productName,
                             'quantityMeasure':quantityMeasure,
                             'quantityRequired':quantityRequired,
                             'price':price,
                             'deliveryLocation':deliveryLocation,
                             'deliverBy':date,
                            'phoneNumber':phoneNumber,
                              'imageUrl':'https://img.freepik.com/free-photo/arrangement-different-fresh-vegetables-with-copy-space_23-2148655300.jpg?size=626&ext=jpg&ga=GA1.1.1410234987.1707580341&semt=ais',
                              'accepted':false,
                              'acceptedBy':'',
                            }
                          ).whenComplete(() {
                            EasyLoading.dismiss();
                            const snackBar = SnackBar(
                              content: Text('Your demand has been uplaoded'),
                              backgroundColor: Colors.green,
                              elevation: 10,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(5),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            nameText.clear();
                            productNameText.clear();
                            quantityMeasureText.clear();
                            quantityRequiredText.clear();
                            productPriceText.clear();
                            deliveryLocationText.clear();
                            phoneNumberText.clear();
                            emailText.clear();
                            setState(() {

                            });
                          // Get.offAll(HomeScreen());

                          });
                        }
                      else
                        {
                          print(false);
                        }
                    },
                    child: Text('Submit')
                )








              ],

            ),
          ),

        ),
      ),
    );
  }
}


