import 'package:farmpicks/views/screens/widget/banner_widget.dart';
import 'package:farmpicks/views/screens/widget/category_item_widget.dart';
import 'package:farmpicks/views/screens/widget/category_text_widget.dart';
import 'package:farmpicks/views/screens/widget/fruits_product_widget.dart';
import 'package:farmpicks/views/screens/widget/home_products.dart';
import 'package:farmpicks/views/screens/widget/location_widget.dart';
import 'package:farmpicks/views/screens/widget/reuseText_widget.dart';
import 'package:farmpicks/views/screens/widget/vegetables_product_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LocationWidget(),
            BannerWidget(),

         //   CategoryItemWidget(),

            CategoryTextWidget(),
            SizedBox(
              height:7
            ),
            HomeProductImage(),
            SizedBox(
              height:3,
            ),
            ReuseTextWidget(title: "Fruits"),
            SizedBox(
              height: 3,
            ),
            FruitsProductImage(),
            SizedBox(
              height: 3,
            ),
            ReuseTextWidget(title: "Vegetables"),
            SizedBox(
              height: 3,
            ),
            VegetablesProductImage(),

          ],
        ),
      ),
    );
  }
}
