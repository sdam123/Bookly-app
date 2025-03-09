import 'package:bookly_app/features/home/presentation/manager/futured_book_cubit/futured_books_cubit.dart';
import 'package:bookly_app/features/home/presentation/view/booke_details_page.dart';
import 'package:bookly_app/features/home/presentation/view/widget/book_details_body.dart';
import 'package:bookly_app/features/home/presentation/view/widget/costom_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class BooksListView extends StatelessWidget {
  const BooksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedBooksCubit, FeaturedBooksState>(
      builder: (context, state) {
        if (state is FeaturedBooksSuccess) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .3,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.books.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to( BookDetailsBody(bookModel: state.books[index],));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: CostomItem(
                      image: state.books[index].volumeInfo.imageLinks.thumbnail,
                    ),
                  ),
                );
              },
              scrollDirection: Axis.horizontal,
            ),
          );
        } else if (state is FeaturedBooksFailur) {
          return Center(child: Text(state.errMessage));
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .3,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Shimmer.fromColors(child: CostomItem(image: 'https://i.pinimg.com/736x/c5/1b/44/c51b44a7a5cc2500bc99358f0d4cbcc7.jpg'), baseColor: Colors.grey[600]!, highlightColor: Colors.grey[500]!)
                );
              },
              scrollDirection: Axis.horizontal,
            ),
          );
        }
      },
    );
  }
}
