import 'package:bloc/bloc.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/data/repos/home_repo.dart';
import 'package:equatable/equatable.dart';

part 'futured_books_state.dart';

class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  FeaturedBooksCubit(this.homeRepo) : super(FeaturedBooksInitial());

 final HomeRepo homeRepo;

 Future<void> fetchFeaturBooks() async {
   emit(FeaturedBooksLooding());
     var result=await homeRepo.fetchFeaturBooks();
     result.fold((feature) => {
      emit(FeaturedBooksFailur(errMessage: feature.errMessage))
     }, (books) => {
      emit(FeaturedBooksSuccess(books: books))
     });

 }
}
