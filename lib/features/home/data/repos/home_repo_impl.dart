

import 'package:bookly_app/core/errors/failure.dart';
import 'package:bookly_app/core/utils/api_service.dart';
import 'package:bookly_app/features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/features/home/data/repos/home_repo.dart';
import 'package:dartz/dartz.dart';

class HomeRepoImpl implements HomeRepo{

  final ApiServic apiServic;

  HomeRepoImpl({required this.apiServic});
  @override
  Future<Either<SeviceFailure, List<BookModel>>> fetchNewsetBooks()async {
    try {

  var data =await apiServic.get(endpoint:
   'volumes?q=computer science&Filltering=free-ebooks&Sorting=newest');
    List<BookModel> books=[];
    //volumes?q=computer science&Filltering=free-ebooks&Sorting=newest'
    for(var item in data['items']){
      books.add(BookModel.fromJson(item));
    }
    return right(books);
} catch (e) {
     return left(SeviceFailure(errMessage: e.toString()));
}

  }
  @override
  Future<Either<SeviceFailure, List<BookModel>>> fetchFeaturBooks() async {
     try {

  var data =await apiServic.get(endpoint:
   'volumes?q=subject:Programming&Filltering=free-ebooks');
    List<BookModel> books=[];
    for(var item in data['items']){
      books.add(BookModel.fromJson(item));
    }
    return right(books);
} catch (e) {
     return left(SeviceFailure(errMessage: e.toString()));
}
  }
  
  @override
  Future<Either<Failure, List<BookModel>>> fetchSimelirBooks({required String category})async {
      try {

  var data =await apiServic.get(endpoint:
   'volumes?q=subject:$category &Sorting=relevance&Filltering=free-ebooks');
    List<BookModel> books=[];
    for(var item in data['items']){
      books.add(BookModel.fromJson(item));
    }
    return right(books);
} catch (e) {
     return left(SeviceFailure(errMessage: e.toString()));
}
  }
  
  @override
  Future<Either<Failure, List<BookModel>>> fetchSearchBooks({required String search}) async{
     try {

  var data =await apiServic.get(endpoint:
   'volumes?q=$search&Filltering=free-ebooks&Sorting=newest');
    List<BookModel> books=[];
    //volumes?q=computer science&Filltering=free-ebooks&Sorting=newest'
    for(var item in data['items']){
      books.add(BookModel.fromJson(item));
    }
    return right(books);
} catch (e) {
     return left(SeviceFailure(errMessage: e.toString()));
}
  }
  
}