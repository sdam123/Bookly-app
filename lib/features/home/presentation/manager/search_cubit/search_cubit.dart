import 'package:bloc/bloc.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/data/repos/home_repo.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.homeRepo) : super(SearchInitial());

   final HomeRepo homeRepo;

 Future<void> fetchSearchBooks({required String search}) async {
   emit(SearchLooding());
     var result=await homeRepo.fetchSearchBooks(search: search);
     result.fold((feature) => {
      emit(SearchFailure(errMessage: feature.errMessage))
     }, (books) => {
      emit(SearchSuccess(books: books))
     });

 }
}
