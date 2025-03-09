import 'package:bookly_app/constants.dart';
import 'package:bookly_app/core/utils/servise_locator.dart';
import 'package:bookly_app/features/home/data/repos/home_repo_impl.dart';
import 'package:bookly_app/features/home/presentation/manager/futured_book_cubit/futured_books_cubit.dart';
import 'package:bookly_app/features/home/presentation/manager/newset_bookes_cubit/newset_books_cubit.dart';
import 'package:bookly_app/features/home/presentation/manager/similer_book_cubit/similer_books_cubit.dart';
import 'package:bookly_app/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';


void main() {
  runApp(const BooklyApp());
  setup();
  
}

class BooklyApp extends StatelessWidget {
  const BooklyApp({super.key});
   
  @override
  Widget build(BuildContext context) {
   
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsetBooksCubit(getIt.get<HomeRepoImpl>()
          
          )..fetchNewsetBooks(),
        ),
        BlocProvider(
          create: (context) =>  FeaturedBooksCubit(getIt.get<HomeRepoImpl>()
          )..fetchFeaturBooks(),
        ), BlocProvider(
          create: (context) =>  SimilerBooksCubit(getIt.get<HomeRepoImpl>())
         
        ),
      ],
      child: GetMaterialApp(  
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: kPrimaryColor),
      
      home: const SplashView(),
    )
    );
          
    
     
  }
}

