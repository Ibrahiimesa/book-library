import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../data/model/book_model.dart';
import '../provider/book_provider.dart';

class AddBookScreen extends StatefulWidget {
  static const routeName = '/add_book';

  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _isEditMode = false;
  Book? _existingBook;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final book = ModalRoute.of(context)?.settings.arguments as Book?;
    if (book != null) {
      _isEditMode = true;
      _existingBook = book;

      _titleController.text = book.title;
      _authorController.text = book.author;
      _yearController.text = book.year.toString();
      _ratingController.text = book.rating.toString();
      _categoryController.text = book.category;
      _imageController.text = book.image;
      _descriptionController.text = book.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditMode ? 'Edit Book' : 'Add a New Book',
          style: GoogleFonts.titilliumWeb(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextFormField(_titleController, 'Title'),
              _buildTextFormField(_authorController, 'Author'),
              _buildTextFormField(_yearController, 'Year', isNumeric: true),
              _buildTextFormField(_ratingController, 'Rating', isNumeric: true),
              _buildTextFormField(_categoryController, 'Category'),
              _buildTextFormField(_imageController, 'Image URL'),
              _buildTextFormField(_descriptionController, 'Description',
                  maxLines: 3),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveBook(context);
                  }
                },
                child: Text(_isEditMode ? 'Save Changes' : 'Add Book'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String label,
      {bool isNumeric = false, int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      maxLines: maxLines,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
      onChanged: (value) {
        _formKey.currentState?.validate();
      },
    );
  }

  void _saveBook(BuildContext context) {
    final newBook = Book(
      id: _existingBook?.id,
      title: _titleController.text,
      author: _authorController.text,
      year: int.parse(_yearController.text),
      rating: double.parse(_ratingController.text),
      category: _categoryController.text,
      image: _imageController.text,
      description: _descriptionController.text,
      favorite: _existingBook?.favorite ?? false,
    );

    if (_isEditMode) {
      Provider.of<BookProvider>(context, listen: false).updateBook(newBook);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Book updated successfully!')),
      );
    } else {
      Provider.of<BookProvider>(context, listen: false).addBook(newBook);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Book added successfully!')),
      );
    }

    Navigator.pop(context, newBook);
  }
}
