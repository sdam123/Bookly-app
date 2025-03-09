import 'package:bloc/bloc.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/data/repos/home_repo.dart';
import 'package:equatable/equatable.dart';

part 'newset_books_state.dart';

class NewsetBooksCubit extends Cubit<NewsetBooksState> {
  NewsetBooksCubit(this.homeRepo) : super(NewsetBooksInitial());

   final HomeRepo homeRepo;

 Future<void> fetchNewsetBooks() async {
   emit(NewsetBooksLooding());
     var result=await homeRepo.fetchNewsetBooks();
     result.fold((feature) => {
      emit(NewsetBooksFailur(errMessage: feature.errMessage))
     }, (books) => {
      emit(NewsetBooksSuccess(books: books))
     });

 }
}
 