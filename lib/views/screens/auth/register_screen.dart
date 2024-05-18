import 'dart:typed_data';

import 'package:farmpicks/controller/auth_controller.dart';
import 'package:farmpicks/views/screens/auth/loginscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final AuthController _authController = AuthController();

  late String email;

  late String fullname;

  late String password;

  bool _isLoading = false;

  Uint8List? _image;

  selectGalleryImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.gallery);
    print(im);
    setState(() {
      _image = im;
    });
  }

  CaptureImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.camera);
    setState(() {
      _image = im;
    });
  }

  registerUser() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String res =
          await _authController.createNewUser(email, fullname, password);
      setState(() {
        _isLoading = false;
      });
      print('success');
      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        Get.to(LoginScreen());

        Get.snackbar('Register Successful', 'Please login to your account',
            backgroundColor: Colors.pink, colorText: Colors.white);
      } else {
        Get.snackbar(
          'Error occured',
          res.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        'Error',
        'Please fill at the fields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 150),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //SizedBox(
                  //   height:120,
                  // ),
                  Text(
                    'Register Account',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 90,
                    width: 90,
                    decoration: const BoxDecoration(
                        color: Colors.white
                    ),
                    child: _image!=null ? Image.memory(_image!):IconButton(
                      onPressed: () {
                        selectGalleryImage();
                        print(_image);
                      },
                      icon: const Icon(
                        CupertinoIcons.photo,
                      ),
                    )
                    ,
                  ),
                 /* Stack(children: [
                    _image == null
                        ? CircleAvatar(
                            radius: 65,
                            child: Icon(
                              Icons.person,
                              size: 70,
                            ),
                          )
                        : CircleAvatar(
                            radius: 65,
                            backgroundImage: MemoryImage(_image!),
                          ),
                    Positioned(
                      right: 0,
                      top: 15,
                      child: IconButton(
                        onPressed: () {
                          selectGalleryImage();
                        },
                        icon: Icon(
                          CupertinoIcons.photo,
                        ),
                      ),
                    ),
                  ]),*/
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email address must not be empty';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      hintText: 'Enter your Email Address',
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      fullname = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Full name must not be empty';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      hintText: 'Enter your Full Name',
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),

                  TextFormField(
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password must not be empty';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'password',
                      hintText: 'Enter your password',
                      prefixIcon: Icon(Icons.lock, color: Colors.pink),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () {
                      registerUser();
                    },
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Register',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 4,
                                  ),
                                ),
                        )),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Already have an account?',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
