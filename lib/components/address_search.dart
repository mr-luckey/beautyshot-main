import 'package:beautyshot/components/place_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  AddressSearch(String sessionToken);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Get.back();
        // close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
    // return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      // We will put the api call here
      future: null,
      builder: (context, AsyncSnapshot snapshot) => query == ''
          ? Container(
        padding: const EdgeInsets.all(16.0),
        child: const Text('Enter your address'),
      )
          : snapshot.hasData
          ? ListView.builder(
        itemBuilder: (context, index) => ListTile(
          // we will display the data returned from our future here
          title:
          Text( snapshot.data[index]),
          onTap: () {
            close(context, snapshot.data[index]);
          },
        ),
        itemCount: snapshot.data!.length,
      )
          : const Text('Loading...'),
    );
  }
}
