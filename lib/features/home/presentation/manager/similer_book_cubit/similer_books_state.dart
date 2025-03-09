part of 'similer_books_cubit.dart';

sealed class SimilerBooksState extends Equatable {
  const SimilerBooksState();

  @override
  List<Object> get props => [];
}

final class SimilerBooksInitial extends SimilerBooksState {}
final class SimilerBooksSuccess extends SimilerBooksState {
  final List<BookModel> books;

  SimilerBooksSuccess({required this.books});
}
final class SimilerBooksLooding extends SimilerBooksState {}
final class SimilerBooksFailur extends SimilerBooksState {
  final String errMessage;

  SimilerBooksFailur({required this.errMessage});
}
