

import 'package:bookly_app/features/home/presentation/view/booke_details_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class  CostomItem extends StatelessWidget {
  const  CostomItem({super.key, required this.image});
   final String image ;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
               height: MediaQuery.of(context).size.height *.3,
               child:  AspectRatio(aspectRatio: 2.7/4,
               child: CachedNetworkImage(imageUrl: image,
               errorWidget: (context, url, error) =>const Icon(Icons.error),
               fit: BoxFit.fill,
               
               )
               ),
      ),
    );
  }
}