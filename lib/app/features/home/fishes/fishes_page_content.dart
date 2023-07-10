import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_angler/app/features/home/fishes/cubit/fishes_cubit.dart';

class FishesPageContent extends StatelessWidget {
  const FishesPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FishesCubit()..start(),
      child: BlocBuilder<FishesCubit, FishesState>(
        builder: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            return Center(
                child: Text('Coś poszło nie tak: ${state.errorMessage}'));
          }
          if (state.isLoading == true) {
            return const Center(child: CircularProgressIndicator());
          }

          final documents = state.documents;

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
        },
      ),
    );
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
