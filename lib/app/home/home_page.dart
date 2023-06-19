import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
          return const AddFishPageContent();
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

class MyAccountPageContent extends StatelessWidget {
  const MyAccountPageContent({
    super.key,
    required this.email,
  });

  final String? email;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Jesteś zalogowany jako $email"),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: const Text('Wyloguj'),
          ),
        ],
      ),
    );
  }
}

class AddFishPageContent extends StatelessWidget {
  const AddFishPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Dodaj rybę'),
    );
  }
}

class FishesPageContent extends StatelessWidget {
  const FishesPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('fishes').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Coś poszło nie tak'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Ładowanie'));
          }

          final documents = snapshot.data!.docs;

          return ListView(
            children: [
              for (final document in documents) ...[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(document['name']),
                      Text(document['size'].toString()),
                      Text(document['data']),
                    ],
                  ),
                ),
              ],
            ],
          );
        });
  }
}

class WeatherPageContent extends StatelessWidget {
  const WeatherPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Pogoda'),
    );
  }
}
