import 'package:flutter/material.dart';
import 'package:favorite_places_app/models/place.dart';

class PlacesList extends StatelessWidget {
  const PlacesList(
      {super.key, required this.places, required this.onTappedItemAtIndex});

  final List<Place> places;
  final void Function(Place) onTappedItemAtIndex;

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'You have no places yet, start adding some!',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
        ],
      ),
    );

    if (places.isNotEmpty) {
      content = ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: places.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 26,
              backgroundImage: FileImage(places[index].image),
            ),
            onTap: () {
              onTappedItemAtIndex(places[index]);
            },
            title: Text(places[index].title),
          );
        },
      );
    }

    return content;
  }
}
