import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
