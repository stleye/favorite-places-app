import 'package:favorite_places_app/screens/new_place_screen.dart';
import 'package:favorite_places_app/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_places_app/providers/places_provider.dart';
import 'package:favorite_places_app/models/place.dart';
import 'package:favorite_places_app/screens/place_details_screen.dart';

class StartingScreen extends ConsumerStatefulWidget {
  const StartingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _StartingScreenState();
  }
}

class _StartingScreenState extends ConsumerState<StartingScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(favoritePlacesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    List<Place> places = ref.watch(favoritePlacesProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text('Your Places',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface)),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NewPlaceScreen()))
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: _placesFuture,
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : PlacesList(
                        places: places,
                        onTappedItemAtIndex: (Place place) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  PlaceDetailsScreen(place: place)));
                        }),
          ),
        ));
  }
}
