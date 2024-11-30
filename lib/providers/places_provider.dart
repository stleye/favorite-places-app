import 'package:favorite_places_app/models/place.dart';
import 'package:riverpod/riverpod.dart';
import 'dart:io';

class PlacesProvider extends StateNotifier<List<Place>> {
  PlacesProvider() : super([]);

  void addPlace(String title, File image, PlaceLocation location) {
    state = [
      ...state,
      Place(
        title: title,
        image: image,
        location: location,
      ),
    ];
  }
}

final favoritePlacesProvider =
    StateNotifierProvider<PlacesProvider, List<Place>>((ref) {
  return PlacesProvider();
});
