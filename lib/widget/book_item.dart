import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/model/book_model.dart';
import '../ui/detail_screen.dart';

class BookItem extends StatelessWidget {
  final Book book;

  const BookItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          BookDetailScreen.routeName,
          arguments: book,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 160,
                width: 110,
                child: Image.network(
                  book.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(book.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: GoogleFonts.robotoSlab(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        )),
                    const SizedBox(height: 8),
                    Text(
                      book.author,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star,
                          size: 22,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          book.rating.toString(),
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.blueGrey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
