import 'package:bookly_app/constants.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/presentation/manager/newset_bookes_cubit/newset_books_cubit.dart';
import 'package:bookly_app/features/home/presentation/view/widget/book_details_body.dart';
import 'package:bookly_app/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';

import 'bookes_item.dart';

import 'package:bookly_app/features/home/presentation/view/widget/costom_body.dart';
import 'package:bookly_app/features/home/presentation/view/widget/costum_appbar.dart';
import 'package:flutter/material.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      physics:  BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CostomAppbar(),
              BooksListView(),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Newset Books',
                  style: Styles.textStyle18,
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
        SliverFillRemaining(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: BestSillerListView(),
          ),
        )
      ],
    );
  }
}

class BestSillerListView extends StatelessWidget {
  const BestSillerListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsetBooksCubit, NewsetBooksState>(
      builder: (context, state) {
        if (state is NewsetBooksSuccess) {
  return ListView.builder(
    
    itemBuilder: (context, index) {
      return  Padding(
        padding:const EdgeInsets.symmetric(vertical: 10),
        child: BestSillerItem(bookes: state.books[index],),
      );
    },
    padding: EdgeInsets.zero,
    itemCount: state.books.length,
    physics: const NeverScrollableScrollPhysics(),
  );
}   else if(state is  NewsetBooksFailur){
  return Center(child: Text(state.errMessage),);
}else {
  return  ListView.builder(
    
    itemBuilder: (context, index) {
      return   Padding(
        padding:const EdgeInsets.symmetric(vertical: 10),
        child: Shimmer.fromColors(child: BestSillerItemLooding(), baseColor: Colors.grey[600]!, highlightColor: Colors.grey[500]!),
      );
    },
    padding: EdgeInsets.zero,
    itemCount: 10,
    physics: const NeverScrollableScrollPhysics(),
  );
}
      } ,
    );
  }
}

class BestSillerItem extends StatelessWidget {
  const BestSillerItem({super.key, required this.bookes});
  final BookModel bookes;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
         Get.to( BookDetailsBody(bookModel: bookes,));
      },
      child: SizedBox(
        height: 125,
        child: Row(
          children: [
             CostomItem(image: bookes.volumeInfo.imageLinks.thumbnail),
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      child:  Text(
                        bookes.volumeInfo.title!,
                        style: Styles.textStyle20,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )),
                  const SizedBox(
                    height: 1,
                  ),
                  Text(bookes.volumeInfo.authors?[0] ?? '',
                      style: Styles.textStyle14.copyWith(
                        color: const Color.fromARGB(255, 208, 207, 207),
                        overflow: TextOverflow.ellipsis
                      )),
                  const SizedBox(
                    height: 1,
                  ),
                  RaitingWegit(Rating: bookes.volumeInfo.averageRating?.toInt() ?? 0,RatingCount: 
                  bookes.volumeInfo.ratingsCount ?? 0,price: 'Free',)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RaitingWegit extends StatelessWidget {
  const RaitingWegit({
    super.key, required this.Rating, required this.RatingCount, required this.price,
  });
  final int Rating;
  final int RatingCount;
   final String price;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          price,
          style: Styles.textStyle14.copyWith(fontWeight: FontWeight.bold),
        ),
      const Spacer(),
       const Icon(
          Icons.star,
          color: Colors.yellow,
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          Rating.toString(),
          style: Styles.textStyle16,
        ),
        const SizedBox(
          width: 5,
        ),
        Text('($RatingCount)',
            style: Styles.textStyle14.copyWith(
              color: Colors.grey,
            ))
      ],
    );
  }
}

class AspectImage extends StatelessWidget {
  const AspectImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.6 / 4,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(8),
            image: const DecorationImage(
                image: AssetImage(testImage), fit: BoxFit.fill)),
      ),
    );
  }
}


class BestSillerItemLooding extends StatelessWidget {
  const BestSillerItemLooding({super.key,});
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      
      height: 125,
      child: Row(
        children: [
         const  CostomItem(image:'https://i.pinimg.com/736x/c5/1b/44/c51b44a7a5cc2500bc99358f0d4cbcc7.jpg'),
          const SizedBox(
            width: 30,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * .5,
                    child:const  Divider(endIndent: 40,indent: 30,color: Colors.white,
                   thickness: 9,),),
                const SizedBox(
                  height: 5,
                ),
                  const Divider(endIndent: 30,indent: 30,
                   thickness: 7,color: Colors.white,),
                const SizedBox(
                  height: 3,
                ),
               const RaitingWegit(Rating:  0,RatingCount: 
                0,price: '',)
              ],
            ),
          ),
        ],
      ),
    );
  }
}