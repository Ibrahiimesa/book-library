import 'package:book_library/provider/book_provider.dart';
import 'package:book_library/ui/add_screen.dart';
import 'package:book_library/ui/detail_screen.dart';
import 'package:book_library/ui/favorite_screen.dart';
import 'package:book_library/ui/home_screen.dart';
import 'package:book_library/ui/profile_screen.dart';
import 'package:book_library/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/navigation.dart';
import 'data/model/book_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookProvider()),
      ],
      child: MaterialApp(
        title: 'Books App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: MainScreen(),
        initialRoute: SplashScreen.routeName,
        navigatorKey: navigatorKey,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          MainScreen.routeName: (context) => MainScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          FavoriteScreen.routeName: (context) => FavoriteScreen(),
          ProfileScreen.routeName: (context) => ProfileScreen(),
          BookDetailScreen.routeName: (context) => BookDetailScreen(
                book: ModalRoute.of(context)?.settings.arguments as Book,
              ),
          AddBookScreen.routeName: (context) => AddBookScreen(),
        },
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  static const routeName = '/main_screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
