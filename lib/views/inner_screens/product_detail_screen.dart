import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmpicks/provider/cart_provider.dart';
import 'package:farmpicks/views/inner_screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class ProductDetailScreen extends ConsumerStatefulWidget {
  final dynamic productData;
  const ProductDetailScreen({super.key, required this.productData});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  int _imageIndex = 0;

/* void callVendor(String phoneNumber) async
  {
    final String url= "tel:$phoneNumber";
    if(await canLaunchUrl(Uri.parse(url)))
      {
        await launchUrl(Uri.parse(url));
      }
    else
      {
        throw('Could not launch phone call');
      }
  }*/
 /* Future<void> launchPhoneDialer(String contactNumber) async {
    final Uri _phoneUri = Uri(
        scheme: "tel",
        path: contactNumber
    );
    try {
      if (await canLaunch(_phoneUri.toString()))
        await launch(_phoneUri.toString());
    } catch (error) {
      throw("Cannot dial");
    }
  }*/


  @override
  Widget build(BuildContext context) {
    Future<void> getData() async {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('farmers')
          .doc(widget.productData['vendorId'])
          .get();

      // Access specific field
      String fieldValue = (documentSnapshot.data() as Map<String,dynamic>)['phoneNumber'];

      print(fieldValue);
    }

    final _cartProvider = ref.read(cartProvider.notifier);
    final cartItem=ref.watch(cartProvider);
    final isInCart = cartItem.containsKey(widget.productData['productId']);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.productData['productName'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      widget.productData['imageUrlList'][_imageIndex],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: widget.productData['imageUrlList'].length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                _imageIndex = index;
                              });
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Image.network(
                                widget.productData['imageUrlList'][index],
                              ),
                            ),
                          );
                        }),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      widget.productData['productName'],
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: false,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '\₹' +
                          widget.productData['productPrice']
                              .toStringAsFixed(2) +
                          ' for 1' +
                          widget.productData['sizeList'][0],
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.blueGrey[600],
              child: ExpansionTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Product Description',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'View More',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                children: [
                  Container(
                    color: Colors.blueGrey,
                    child: Text(
                      widget.productData['description'],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(widget.productData['storeImage']),
              ),
              title: Text(
                widget.productData['name'],
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'See Profile',
                style:
                    TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)
                      {
                       return ChatScreen(
                         farmerId: widget.productData['vendorId'],
                         buyerId: FirebaseAuth.instance.currentUser!.uid,
                         productId: widget.productData['productId'],
                         productName:widget.productData['productName'],
                         farmerName: widget.productData['name'],
                       );
                      })
                      );
                    },
                    icon: Icon(CupertinoIcons.chat_bubble_fill),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed:isInCart ? null : (){
                        _cartProvider.addProducttoCart(widget.productData['productName'], widget.productData['productId'], widget.productData['imageUrlList'][0], 1, widget.productData['productQuantity'], widget.productData['productPrice'], widget.productData['vendorId'],widget.productData['sizeList'][0]);
                        print(_cartProvider.getCartItems.values.first.productName);
                       // print(_cartProvider.getCartItems.values.first.imageUrl);
                      }, child:
                    Text( isInCart ? "In Cart" :
                      'Add to cart',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                      style: ButtonStyle(
                       backgroundColor: isInCart ? MaterialStatePropertyAll<Color>(Colors.grey) :  MaterialStatePropertyAll<Color>(Colors.pink),

                      ),),
                  ),
                  IconButton(
                    onPressed: () async{
                      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
                          .collection('farmers')
                          .doc(widget.productData['vendorId'])
                          .get();

                      // Access specific field
                      String fieldValue = (documentSnapshot.data() as Map<String,dynamic>)['phoneNumber'];

                      print(fieldValue);


                    //  print(documentSnapshot.data[]);
                     UrlLauncher.launchUrl(Uri.parse('tel: '+fieldValue));

                    },
                    icon: Icon(CupertinoIcons.phone_fill),
                  )

                ],
              ),
            ),

          ],
        ),

      ),

     /* bottomSheet: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            IconButton(
              onPressed: () {

              },
              icon: Icon(CupertinoIcons.chat_bubble),
            ),
            IconButton(
              onPressed: () {

              },
              icon: Icon(CupertinoIcons.phone),
            )

          ],
        ),
      ),
      */
    );
  }
}
