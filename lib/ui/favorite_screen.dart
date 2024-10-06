import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/book_provider.dart';
import '../widget/book_item.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName = '/favorite';

  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Books',
          style: GoogleFonts.titilliumWeb(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<BookProvider>(
        builder: (context, bookProvider, child) {
          final favoriteBooks = bookProvider.favoriteBooks;

          if (favoriteBooks.isEmpty) {
            return const Center(child: Text('No favorite books available.'));
          }

          return ListView.builder(
            itemCount: favoriteBooks.length,
            itemBuilder: (context, index) {
              return BookItem(book: favoriteBooks[index]);
            },
          );
        },
      ),
    );
  }
}
