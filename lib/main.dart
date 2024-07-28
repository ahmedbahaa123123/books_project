import 'package:books_projects/logic/home_cubit.dart';
import 'package:books_projects/screens/buiseness_screen.dart';
import 'package:books_projects/screens/everything_screen.dart';
import 'package:books_projects/screens/image_screen.dart';
import 'package:books_projects/screens/programming_screen.dart';
import 'package:books_projects/screens/sceince_screen.dart';
import 'package:books_projects/screens/sports_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Our Library',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ImageScreen(), 
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    const EverythingScreen(),
    const ProgrammingScreen(),
    const BuisenessScreen(),
    const SceinceScreen(),
    const SportsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        BlocProvider.of<HomeCubit>(context).getAllBooks();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.black54,
        selectedLabelStyle: const TextStyle(color: Colors.black54),
        selectedFontSize: 14.0,
        unselectedLabelStyle: const TextStyle(color: Colors.black54),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.code),
            label: 'Programming',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.science),
            label: 'Science',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_basketball),
            label: 'Sports',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
