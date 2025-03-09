

import 'package:bookly_app/features/home/presentation/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:bookly_app/constants.dart';
import 'package:get/get.dart';
class SplashViewBody extends StatefulWidget {
  const SplashViewBody({
    super.key,
  });

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> with SingleTickerProviderStateMixin{

 late AnimationController animationController;
 late Animation<Offset> slidingText;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSlideAnimation();
     navigaToHomePage();
  }
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(logo),
       AnimatedBuilder(
        animation: slidingText,
         builder: (context,_) {
           return SlideTransition(
            position: slidingText,
            child: const Text('read books free',textAlign: TextAlign.center,));
         }
       )
      ],
    );
  }
  void navigaToHomePage() {
    Future.delayed(const Duration(seconds: 2),() {
     return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
       return const HomePage();
     },
     
     ), (route) => false);
   },);
 }
 void initSlideAnimation() {
      animationController=AnimationController(vsync: this,duration:const Duration( milliseconds: 500));
   slidingText=Tween<Offset>(begin:const Offset(0, 2),end: Offset.zero).animate(animationController);
   animationController.forward();
 }
}

