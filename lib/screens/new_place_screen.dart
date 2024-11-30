import 'package:favorite_places_app/models/place.dart';
import 'package:favorite_places_app/widgets/image_input.dart';
import 'package:favorite_places_app/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:favorite_places_app/providers/places_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

class NewPlaceScreen extends ConsumerStatefulWidget {
  const NewPlaceScreen({super.key});

  @override
  ConsumerState<NewPlaceScreen> createState() => _NewPlaceScreenState();
}

class _NewPlaceScreenState extends ConsumerState<NewPlaceScreen> {
  final _titleController = TextEditingController();
  File? _storedImage;
  PlaceLocation? _selectedLocation;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _storedImage == null ||
        _selectedLocation == null) {
      return;
    }

    ref
        .read(favoritePlacesProvider.notifier)
        .addPlace(_titleController.text, _storedImage!, _selectedLocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.onSurface)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              TextField(
                style: const TextStyle(color: Colors.white),
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              const SizedBox(height: 10),
              ImageInput(
                onSelectImage: (image) {
                  _storedImage = image;
                },
              ),
              const SizedBox(height: 10),
              LocationInput(onSelectLocation: (place) {
                _selectedLocation = place;
              }),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                  onPressed: _savePlace,
                  label: const Text('Add Place'),
                  icon: const Icon(Icons.add)),
            ],
          ),
        ),
      ),
    );
  }
}
