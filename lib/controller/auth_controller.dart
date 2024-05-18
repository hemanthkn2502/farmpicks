import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AuthController{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage=FirebaseStorage.instance;


  String? fileName;

  pickProfileImage(ImageSource source)async{
    final ImagePicker _pickImage= ImagePicker();

    XFile? _file= await _pickImage.pickImage(source: source);



    if(_file!=null)
    {
      return await _file.readAsBytes();
      fileName=_file.name;
    }
    else
    {
      print('No image is selected');
    }

  }

/*  _uplaodUserstorageImage(Uint8List? image)async
  {
    Reference ref=_firebaseStorage.ref().child('storeImage').child(_auth.currentUser!.uid);

    UploadTask uploadTask=ref.putData(image!);

    print(image);

    TaskSnapshot snapshot=await uploadTask;

    String downloadUrl= await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }*/

  Future<String> createNewUser(String email,String fullname,String password) async{
  String res='An error occured';

  try{
    //String downloadUrl=await _uplaodUserstorageImage(image);
   UserCredential userCredential= await _auth.createUserWithEmailAndPassword(email: email, password: password);
  await _firestore.collection('buyers').doc(userCredential.user!.uid).set({
     'fullName': fullname,
     'email': email,
     'buyerId': userCredential.user!.uid,
   });
   res='success';
  }catch(e){
    res=e.toString();
  }
  return res;
  }

  Future<String> loginUser(String email,String password)async{
    String res="some error occured";
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res='success';
    }
    catch(e){
      res=e.toString();
    }
    return res;
  }
}