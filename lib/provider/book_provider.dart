import 'package:flutter/material.dart';

import '../data/db/database_helper.dart';
import '../data/model/book_model.dart';

class BookProvider with ChangeNotifier {
  List<Book> _books = [];

  List<Book> get books => _books;

  List<Book> get favoriteBooks =>
      _books.where((book) => book.favorite).toList();

  Future<void> fetchBooks() async {
    _books = await DatabaseHelper().fetchBooks();
    notifyListeners();
  }

  Future<void> addBook(Book book) async {
    await DatabaseHelper().addBook(book);
    await fetchBooks();
  }

  Future<void> updateBook(Book updatedBook) async {
    await DatabaseHelper().updateBook(updatedBook);

    final index = _books.indexWhere((book) => book.id == updatedBook.id);
    if (index != -1) {
      _books[index] = updatedBook;
      notifyListeners();
    }
  }

  Future<void> deleteBook(int id) async {
    await DatabaseHelper().deleteBook(id);
    await fetchBooks();
    notifyListeners();
  }

  void toggleFavorite(Book book) async {
    final updatedBook = book.copyWith(favorite: !book.favorite);
    await DatabaseHelper().updateBook(updatedBook);
    fetchBooks();
  }
}
