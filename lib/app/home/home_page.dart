import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pro_angler/app/home/add_fish/add_fish_page_content.dart';
import 'package:pro_angler/app/home/fishes/fishes_page_content.dart';
import 'package:pro_angler/app/home/my_account/my_account_page_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(builder: (context) {
          if (currentIndex == 0) {
            return const Text('Pogoda');
          }
          if (currentIndex == 1) {
            return const Text('Moje okazy');
          }
          if (currentIndex == 2) {
            return const Text('Dodaj rybę');
          }
          return const Text('Moje konto');
        }),
      ),
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return const WeatherPageContent();
        }
        if (currentIndex == 1) {
          return const FishesPageContent();
        }
        if (currentIndex == 2) {
          return AddFishPageContent(onSave: () {
            setState(() {
              currentIndex = 1;
            });
          });
        }

        return MyAccountPageContent(email: widget.user.email);
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Pogoda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bubble_chart_outlined),
            label: 'Moje okazy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'Dodaj rybę',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Moje konto',
          ),
        ],
      ),
    );
  }
}
