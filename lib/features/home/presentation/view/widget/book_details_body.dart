import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/presentation/manager/similer_book_cubit/similer_books_cubit.dart';

import 'package:bookly_app/features/home/presentation/view/widget/costom_body.dart';


import 'package:bookly_app/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import 'package:url_launcher/url_launcher.dart';

class BookDetailsBody extends StatefulWidget {
  const BookDetailsBody({super.key, this.bookModel});
  final BookModel? bookModel;

  @override
  State<BookDetailsBody> createState() => _BookDetailsBodyState();
}

class _BookDetailsBodyState extends State<BookDetailsBody> {

  @override
  void initState() {
   
    BlocProvider.of<SimilerBooksCubit>(context).fetchSimilerBooks(category: widget.bookModel!.volumeInfo.categories?[0] ?? '' );
  } 
 

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CostomAppBarD(),
                  const SizedBox(
                    height: 20,
                  ),
                  CostomItem(
                    image: widget.bookModel!.volumeInfo.imageLinks.thumbnail,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Text(
                    widget.bookModel!.volumeInfo.title!,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: Styles.textStyle30.copyWith(fontSize: 28,overflow: TextOverflow.ellipsis,
                  ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Opacity(
                      opacity: .7,
                      child: Text(
                        
                          
                        widget.bookModel!.volumeInfo.authors![0],
                         textAlign: TextAlign.center ,
                        style: Styles.textStyle16
                            .copyWith(fontStyle: FontStyle.italic,overflow: TextOverflow.ellipsis,
                            ),
                      )),
                  const SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                       Text(
                        widget.bookModel!.volumeInfo.averageRating?.toString() ?? '0'  ,
                        style: Styles.textStyle16,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text('(${widget.bookModel!.volumeInfo.ratingsCount?? 0 })',
                          style: Styles.textStyle14.copyWith(
                            color: Colors.grey,
                          )),
                      const SizedBox(
                        height: 37,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                   CustomButton(book: widget.bookModel!,),
                  const Expanded(
                      child: SizedBox(
                    height: 45,
                  )),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'You can also like',
                        style: Styles.textStyle14,
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                   SmilerListView(image: widget.bookModel!.volumeInfo.imageLinks.thumbnail,),
                  const SizedBox(
                    height: 8,
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}

class SmilerListView extends StatelessWidget {
  const SmilerListView({super.key, required this.image});
  final String image;
     
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .15,
      child: BlocBuilder<SimilerBooksCubit, SimilerBooksState>(
        builder: (context, state) {

          if (state is SimilerBooksSuccess) {
  return ListView.builder(
    physics: const BouncingScrollPhysics(),
    itemCount: state.books.length,
    itemBuilder: (context, index) {
      return  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return BookDetailsBody(bookModel: state.books[index],);
            },));
          },
          child: CostomItem(
            image:
                state.books[index].volumeInfo.imageLinks.thumbnail,
          ),
        ),
      );
    },
    scrollDirection: Axis.horizontal,
  );
}  else if(state is SimilerBooksFailur){
     return Center(child: Text(state.errMessage),);
} else {
 return  ListView.builder(
    physics: const BouncingScrollPhysics(),
    itemCount:10,
    itemBuilder: (context, index) {
      return  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: GestureDetector(
        
          child: Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[500]!,
            child: CostomItem(
              image:
                 'https://i.pinimg.com/736x/c5/1b/44/c51b44a7a5cc2500bc99358f0d4cbcc7.jpg',
            ),
          ),
        ),
      );
    },
    scrollDirection: Axis.horizontal,
  );;
}
        },
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.book});
  final BookModel book;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child:  Row(
        children: [
         const CustumTextButton(
            text: 'Free',
            backgroundColor: Colors.white,
            textColor: Colors.black,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
          ),
          CustumTextButton(
             onPressed: () async {
                 Uri uri =Uri.parse(book.volumeInfo.previewLink!);
                 if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);          
                 }           
             },
              text: 'FreePreview',
                
              backgroundColor:const Color(0xffEF8262),
              textColor: Colors.white,
              borderRadius:const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12)))
        ],
      ),
    );
  }
}

class CustumTextButton extends StatelessWidget {
  const CustumTextButton(
    
      {super.key,
      required this.backgroundColor,
      this.borderRadius,
      required this.textColor,
      required this.text, this.onPressed});

  final Color backgroundColor;
  final BorderRadius? borderRadius;
  final Color textColor;
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 48,
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          style: TextButton.styleFrom(
              backgroundColor: backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(16),
              )),
        ),
      ),
    );
  }
}

class CostomAppBarD extends StatelessWidget {
  const CostomAppBarD({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.card_travel),
        )
      ],
    );
  }
}
