import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peer_to_peer_multimedia_sharing_application/network_logic/peers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FileSearch extends SearchDelegate {
  final String id;
  Map fileAddr = {};
  List<String> suggestions = [];

  FileSearch({required this.id});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    searchIndexer(query);
    print(fileAddr);

    List<String> ipAdresses = [];
    List<String> filePaths = [];

    fileAddr.forEach((key, value) {
      ipAdresses.add(key[0]);
      filePaths.add(value);
    });

    final results = ipAdresses;

    return ListView(
      children: results
          .map((addr) => ListTile(
                title: Text(addr),
                onTap: () {
                  close(context, null);
                },
              ))
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = suggestions
        .where((suggestion) => suggestion.toLowerCase().contains(query));

    if (results.isEmpty) {
      saveSearchQuery(query);
    }

    return ListView(
      children: results
          .map((suggestion) => ListTile(
                title: Text(
                  suggestion,
                  style: const TextStyle(color: Colors.deepPurple),
                ),
                onTap: () {
                  query = suggestion;
                },
              ))
          .toList(),
    );
  }

  @override
  void showSuggestions(BuildContext context) {
    super.showSuggestions(context);
    loadSearchHistory();
  }

  void loadSearchHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('search_history') ?? [];
    suggestions =
        history.reversed.toList(); // Reversed to show latest searches first
  }

  void saveSearchQuery(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('search_history') ?? [];
    history.remove(value); // Remove existing entry to place it at the top
    history.add(value);
    prefs.setStringList('search_history', history);
  }

  void searchIndexer(String query) async {
    final result = await Peers.searchPublicFiles(fileName: query, id: id);
    fileAddr = jsonDecode(result);
  }
}
