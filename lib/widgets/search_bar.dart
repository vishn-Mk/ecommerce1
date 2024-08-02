import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  _MySearchBarState createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final TextEditingController _controller = TextEditingController();

  void _onSearch(String query) {
    // Handle the search query
    print("Searching for: $query");
    // You can add your search logic here, e.g., API call, filtering list, etc.
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: Colors.grey,
            size: 30,
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            flex: 4,
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
              ),
              onSubmitted: _onSearch, // Call _onSearch when the user submits the query
            ),
          ),
          Container(
            height: 25,
            width: 1.5,
            color: Colors.grey,
          ),
          IconButton(
            onPressed: () {
              _onSearch(_controller.text); // Call _onSearch when the button is pressed
            },
            icon: Icon(
              Icons.tune,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
