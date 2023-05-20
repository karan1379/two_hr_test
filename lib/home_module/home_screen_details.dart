import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:two_hr_test/data/image_model.dart';

class HomeScreenDetails extends StatelessWidget {
  ImageModel model;
  HomeScreenDetails({required this.model,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Product Details"),
      ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             CachedNetworkImage(
               height: Get.height*0.5,
               imageUrl:model.image??"",
               imageBuilder: (context, imageProvider)=>
                   Container(
                     decoration: BoxDecoration(
                       image: DecorationImage(
                           image: imageProvider,
                           fit: BoxFit.fill
                       ),
                     ),
                   ),
               errorWidget: (context, url, error) =>
                   Container(
                     decoration:const BoxDecoration(
                       image: DecorationImage(
                           image: AssetImage("assets/images/placeholder.jpeg"),
                           fit: BoxFit.fill
                       ),
                     ),
                   ),
             ),
             Container(
               margin: EdgeInsets.only(top: 10),
                 color: const Color(0x80000000),
                 padding: const EdgeInsets.all(5),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text("${model.title}",
                       style: const TextStyle(
                           color: Colors.white,
                           fontSize: 17.0,
                           fontWeight: FontWeight.w600),
                     ),
                     Text("Price : ${model.price}",
                       style: const TextStyle(
                           color: Colors.white,
                           fontSize: 17.0,
                           fontWeight: FontWeight.w600),
                     ),
                   ],
                 ))
           ],
        ),
    );
  }
}
