import 'package:book_library/widget/book_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/book_provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<BookProvider>(context, listen: false).fetchBooks();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Books',
          style: GoogleFonts.titilliumWeb(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: BookSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: Consumer<BookProvider>(
        builder: (context, bookProvider, child) {
          if (bookProvider.books.isEmpty) {
            return const Center(child: Text('No books available.'));
          }

          return ListView.builder(
            itemCount: bookProvider.books.length,
            itemBuilder: (context, index) {
              return BookItem(book: bookProvider.books[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_book');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BookSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // Clear search query
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context, listen: false);

    final searchResults = bookProvider.books.where((book) {
      return book.title.toLowerCase().contains(query.toLowerCase()) ||
          book.author.toLowerCase().contains(query.toLowerCase());
    }).toList();

    if (searchResults.isEmpty) {
      return const Center(child: Text('No matching books found.'));
    }

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return BookItem(book: searchResults[index]);
      },
    );
  }
}
