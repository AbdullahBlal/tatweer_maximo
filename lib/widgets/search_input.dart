import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({
    super.key,
    required this.onSearchTextChange,
    required this.searchableItem,
    required this.searchBy,
    required this.label,
  });
  final String label;
  final Function onSearchTextChange;
  final int searchableItem;
  final String searchBy;

  @override
  Widget build(context) {
    Widget content = TextField(
      onChanged: (text) {
        onSearchTextChange(text, searchableItem);
      },
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
      ),
      cursorColor: Theme.of(context).colorScheme.secondary,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          prefixIcon: const Icon(Icons.search),
          prefixIconColor: Theme.of(context).colorScheme.outline,
          filled: true,
          fillColor: const Color.fromARGB(255, 214, 212, 212),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  width: 1.0),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 214, 212, 212), width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: 'Search by $searchBy',
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.outline)),
    );
    return content;
  }
}
