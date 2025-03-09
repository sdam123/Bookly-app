import 'package:bloc/bloc.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/data/repos/home_repo.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'similer_books_state.dart';

class SimilerBooksCubit extends Cubit<SimilerBooksState> {

  SimilerBooksCubit(this.homeRepo) : super(SimilerBooksInitial());

     final HomeRepo homeRepo;

 Future<void> fetchSimilerBooks({required String category}) async {
   emit(SimilerBooksLooding());
     var result=await homeRepo.fetchSimelirBooks(category: category);
     result.fold((feature) => {
      emit(SimilerBooksFailur(errMessage: feature.errMessage))
     }, (books) => {
      emit(SimilerBooksSuccess(books: books))
     });
 }
}
