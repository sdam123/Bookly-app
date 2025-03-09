

import 'package:bookly_app/constants.dart';
import 'package:bookly_app/features/home/presentation/view/searsh_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CostomAppbar extends StatelessWidget {
  const CostomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 32),
      child: Row(children: [
        Image.asset(logo,height: 18,),
       const Spacer(),
        IconButton(onPressed: () {
             Get.to(SearshPage());
        }, icon:const Icon(Icons.search,
        size: 24,))
      ],),
    );
  }
}