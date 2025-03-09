part of 'newset_books_cubit.dart';

sealed class NewsetBooksState extends Equatable {
  const NewsetBooksState();

  @override
  List<Object> get props => [];
}

final class NewsetBooksInitial extends NewsetBooksState {}
final class NewsetBooksSuccess extends NewsetBooksState {
  final List<BookModel> books;

  NewsetBooksSuccess({required this.books});
}
final class NewsetBooksLooding extends NewsetBooksState {}
final class NewsetBooksFailur  extends NewsetBooksState {
  final String errMessage;

  NewsetBooksFailur({required this.errMessage});
}
