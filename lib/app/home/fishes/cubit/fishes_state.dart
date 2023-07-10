part of 'fishes_cubit.dart';

@immutable
class FishesState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;
  final bool isLoading;
  final String errorMessage;

  const FishesState(
      {required this.documents,
      required this.isLoading,
      required this.errorMessage});
}
