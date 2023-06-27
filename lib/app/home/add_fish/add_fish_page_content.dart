import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddFishPageContent extends StatefulWidget {
  const AddFishPageContent({
    super.key,
  });

  @override
  State<AddFishPageContent> createState() => _AddFishPageContentState();
}

class _AddFishPageContentState extends State<AddFishPageContent> {
  var fishName = '';
  var fishSize = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Podaj gatunek ryby',
            ),
            onChanged: (newValue) {
              setState(() {
                fishName = newValue;
              });
            },
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Podaj wymiar ryby',
            ),
            onChanged: (newValue) {
              setState(() {
                fishSize = newValue;
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              FirebaseFirestore.instance.collection('fishes').add(
                {'name': fishName, 'size': fishSize, 'data': '30.03.2023'},
              );
            },
            child: const Text('Dodaj'),
          ),
        ],
      ),
    );
  }
}
