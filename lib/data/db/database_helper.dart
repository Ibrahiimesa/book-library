import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/book_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'books_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create the books table
    await db.execute('''
      CREATE TABLE books(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        author TEXT,
        year INTEGER,
        rating DOUBLE,
        category TEXT,
        image TEXT,
        description TEXT,
        favorite INTEGER DEFAULT 0
      )
    ''');

    await _insertInitialData(db);
  }

  Future<void> _insertInitialData(Database db) async {
    List<Map<String, dynamic>> bookData = [
      {
        "title": "Imperfect",
        "author": "David Adams",
        "year": 2012,
        "rating": 3.9,
        "category": "Fiction",
        "image":
            "https://books.google.com/books/publisher/content/images/frontcover/fnUbAgAAQBAJ?fife=w480-h690",
        "description":
            "On Belthas IV, the great forge world in the inner sphere of Toralii space, thousands of constructs -- artificial slaves -- are manufactured every week. They are initially identical and indistinguishable from the other until each is implanted with a stock neural net. From that moment onward every construct is different.They all have one thing in common, though; all constructs are bound by rules. They serve. They do not question their place. They do not betray.Each construct is different, but some are more different than others..."
      },
      {
        "title": "Breakers: Volume 1",
        "author": "Edward W. Robertson",
        "year": 2014,
        "rating": 4.2,
        "category": "Fiction",
        "image":
            "https://books.google.com/books/publisher/content/images/frontcover/zmyfAgAAQBAJ?fife=w480-h690",
        "description":
            "In New York, Walt Lawson is about to lose his girlfriend Vanessa. In Los Angeles, Raymond and Mia James are about to lose their house. Within days, none of it will matter.When Vanessa dies of the flu, Walt is devastated. But she isn't the last. The virus quickly kills billions, reducing New York to an open grave and LA to a chaotic wilderness of violence and fires. As Raymond and Mia hole up in an abandoned mansion, where they learn to function without electricity, running water, or neighbors, Walt begins an existential walk to LA, where Vanessa had planned to move when she left him. He expects to die along the way.Months later, a massive vessel appears above Santa Monica Bay. Walt is attacked by a crablike monstrosity in a mountain stream. The virus that ended humanity wasn't created by humans. It was inflicted from outside. The colonists who sent it are ready to finish the job--and Earth's survivors may be too few and too weak to resist."
      },
      {
        "title":
            "The Adventure of the Dying Detective (ILLUSTRATED): THE SHERLOCK HOLMES STORY",
        "author": "Sir Arthur Conan Doyle",
        "year": 2021,
        "rating": 3.0,
        "category": "Fiction",
        "image":
            "https://books.google.com/books/publisher/content/images/frontcover/TX4xEAAAQBAJ?fife=w480-h690",
        "description":
            "This book has been considered by academicians and scholars of great significance and value to literature. This forms a part of the knowledge base for future generations. We havent used any OCR or photocopy to produce this book. The whole book has been typeset again to produce it without any errors or poor pictures and errant marks.This early work by Arthur Conan Doyle was originally published in 1917 and we are now republishing it with a brand new introductory biography as part of our Sherlock Holmes series. Arthur Conan Doyle was born in Edinburgh, Scotland, in 1859. It was between 1876 and 1881, while studying medicine at the University of Edinburgh, that he began writing short stories, and his first piece was published in Chambers's Edinburgh Journal before he was 20. In 1887, Conan Doyle's first significant work, A Study in Scarlet, appeared in Beeton's Christmas Annual. It featured the first appearance of detective Sherlock Holmes, the protagonist who was to eventually make Conan Doyle's reputation. A prolific writer, Conan Doyle continued to produce a range of fictional works over the following years. We are republishing these classic works in affordable, high quality, modern editions, using the original text and artwork."
      },
      {
        "title": "The Fellowship of the Ring (The Lord of the Rings, Book 1)",
        "author": "J. R. R. Tolkien",
        "year": 2009,
        "rating": 4.6,
        "category": "Fiction",
        "image":
            "https://books.google.com/books/content/images/frontcover/xFr92V2k3PIC?fife=w480-h690",
        "description":
            "Darkness Will Bind Them... watch The Lord of the Rings: The Rings of Power season 2 on Prime VideoThe first part of J. R. R. Tolkien’s epic adventureTHE LORD OF THE RINGS‘A most remarkable feat’GuardianIn a sleepy village in the Shire, a young hobbit is entrusted with an immense task. He must make a perilous journey across Middle-earth to the Cracks of Doom, there to destroy the Ruling Ring of Power – the only thing that prevents the Dark Lord Sauron’s evil dominion.Thus begins J. R. R. Tolkien’s classic tale of adventure, which continues in The Two Towers and The Return of the King."
      },
      {
        "title":
            "Majapahit: Intrigue, Betrayal and War in Indonesia’s Greatest Empire",
        "author": "Herald van der Linde",
        "year": 2024,
        "rating": 0.0,
        "category": "Biographies & memoirs",
        "image":
            "https://books.google.com/books/publisher/content/images/frontcover/QOUREQAAQBAJ?fife=w480-h690",
        "description":
            "Discover Majapahit, the mighty empire in Southeast Asia that many have never heard of. In the 14th and 15th centuries, the Majapahit kingdom reigned supreme in eastern Java, and its influence stretched far and wide, throughout present-day Indonesia, parts of the Malay peninsula and the island of Tumasek, now Singapore. Majapahit's army famously repelled Kublai Khan's invasion, and its formidable navy humbled even the renowned Portuguese mariners. Walk the bustling streets of Majapahit, a melting pot of aristocratic Javanese, shaven-head Brahmins, hermits in bark cloth, widows dressed in white, and Chinese, Persian and Arab traders. Discover beautiful temples and imposing palaces, and markets brimming with goods from all over Asia. At the heart of Majapahit's story are eccentric kings and queens embroiled in bloody family feuds, and a tipsy court scribe who has the good sense to write down everything he sees. Witness the drama of royal intrigues, murders, revenge and war. This is not just the story of an empire's rise and fall, it is an exploration of a society rich in religious diversity, social tolerance and artistic achievement, and a society - much like Indonesia today - which must navigate its way in the challenging tapestry of Chinese and Southeast Asian geopolitics."
      },
    ];

    for (var book in bookData) {
      await db.insert('books', book);
    }
  }

  Future<List<Book>> fetchBooks() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('books');

      return List.generate(maps.length, (i) {
        return Book.fromMap(maps[i]);
      });
    } catch (e) {
      throw Exception('Failed to load books: $e');
    }
  }

  Future<void> addBook(Book book) async {
    try {
      final db = await database;
      await db.insert(
        'books',
        book.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw Exception('Failed to add book: $e');
    }
  }

  Future<void> updateBook(Book book) async {
    final db = await database;
    await db.update(
      'books',
      book.toMap(),
      where: 'id = ?',
      whereArgs: [book.id],
    );
  }

  Future<void> deleteBook(int id) async {
    try {
      final db = await database;
      await db.delete(
        'books',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception('Failed to delete book: $e');
    }
  }
}
