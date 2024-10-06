import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../data/model/book_model.dart';
import '../provider/book_provider.dart';

class BookDetailScreen extends StatelessWidget {
  static const routeName = '/detail_book';
  final Book book;

  const BookDetailScreen({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Image and gradient background
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: NetworkImage(book.image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color(0xFFFDFDF6),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer<BookProvider>(
                builder: (context, bookProvider, _) {
                  final updatedBook =
                      bookProvider.books.firstWhere((b) => b.id == book.id);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 220),
                      Text(
                        updatedBook.title,
                        style: GoogleFonts.robotoSlab(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                updatedBook.author,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              Text(
                                '${updatedBook.year} ${updatedBook.category}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: Icon(
                                  updatedBook.favorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                ),
                                iconSize: 20,
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                onPressed: () {
                                  Provider.of<BookProvider>(context,
                                          listen: false)
                                      .toggleFavorite(updatedBook);

                                  final newFavoriteStatus =
                                      !updatedBook.favorite;
                                  final snackBarMessage = newFavoriteStatus
                                      ? '${updatedBook.title} added to favorites'
                                      : '${updatedBook.title} removed from favorites';

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(snackBarMessage),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                iconSize: 20, // Reduced icon size
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/add_book',
                                    arguments: updatedBook,
                                  ).then((result) {
                                    if (result != null) {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        routeName,
                                        arguments: result,
                                      );
                                    }
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                iconSize: 20, // Reduced icon size
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Confirm Delete'),
                                        content: const Text(
                                            'Are you sure you want to delete this book?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              final bookId = updatedBook.id;
                                              if (bookId != null) {
                                                Provider.of<BookProvider>(
                                                        context,
                                                        listen: false)
                                                    .deleteBook(bookId);
                                              }
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Delete'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text('Description:',
                          style: GoogleFonts.robotoSlab(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(height: 8),
                      Text(
                        updatedBook.description,
                        style: GoogleFonts.robotoSlab(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  );
                },
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(0.50),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
