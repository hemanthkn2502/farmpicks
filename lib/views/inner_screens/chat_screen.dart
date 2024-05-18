import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final  String farmerId;
  final String buyerId;
  final String productId;
  final String productName;
  final String farmerName;
  const ChatScreen({super.key,required this.farmerId,required this.buyerId,required this.productId,required this.productName,required this.farmerName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  late Stream<QuerySnapshot> _chatStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chatStream=_firestore.collection('chats')
        .where('buyerId',isEqualTo: widget.buyerId)
        .where('farmerId',isEqualTo: widget.farmerId)
        .where('productId',isEqualTo: widget.productId)
        .orderBy("timestamp",descending: false)
        .snapshots();
  }

  void _sendMessage()async{

    DocumentSnapshot farmerDoc=await _firestore.collection('farmers').doc(widget.farmerId).get();
    DocumentSnapshot buyerDoc=await _firestore.collection('buyers').doc(widget.buyerId).get();
    String message = _messageController.text.trim();

    if(message.isNotEmpty)
      {
        await _firestore.collection('chats').add({
          'productId':widget.productId,
          'buyerName':(buyerDoc.data() as Map<String,dynamic>)['fullName'],
          'farmerName':widget.farmerName,
          'farmerPhoto':(farmerDoc.data() as Map<String,dynamic>)['storeImage'],
          'buyerId':widget.buyerId,
          'farmerId':widget.farmerId,
          'message':message,
          'senderId':FirebaseAuth.instance.currentUser!.uid,
          'timestamp':DateTime.now(),
        });
      }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white38,

        title: Text('Chat Screen'+ "  >  " +widget.productName,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(child: StreamBuilder<QuerySnapshot>(
              stream: _chatStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading');
                }

                return ListView(

                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    String senderId = data['senderId'];
                    bool isBuyer = senderId == widget.buyerId;

                    String senderType = isBuyer ? "Buyer" : "Seller";

                    bool isBuyerMessage = senderId == FirebaseAuth.instance.currentUser!.uid;
                    return ListTile(
                      leading: isBuyerMessage ? CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Image.asset('assets/icons/user_icon.png'),

                      ):CircleAvatar(
                      //  child: Image.network(data['farmerPhoto']),
                        backgroundImage: NetworkImage(data['farmerPhoto']),
                      ),
                      title:Text(data['message'],
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),

                      ),
                      subtitle: Text('Sent by '+ senderType),

                    );
                  }).toList(),
                );
              },
            ),),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(

                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Type a message',

                        ),
                      )
                  ),
                  IconButton(onPressed: () async{
                    _sendMessage();
                    Future.delayed(Duration(seconds: 2), () {
                      _messageController.text="";
                    });


                  }, icon: Icon(Icons.send))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
