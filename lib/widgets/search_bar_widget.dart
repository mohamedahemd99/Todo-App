import 'package:flutter/material.dart';

import 'input_decoration_widget.dart';

class SearchBarWidget extends StatefulWidget {
  final TextEditingController searchController;
  final Function() searchAction;
  final Function(String)? onChange;

  const SearchBarWidget(
      {Key? key,
      required this.searchController,
      required this.searchAction,
      this.onChange})
      : super(key: key);

  @override
  SearchBarWidgetState createState() => SearchBarWidgetState();
}

class SearchBarWidgetState extends State<SearchBarWidget> {
  late int selectedId;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) => widget.searchAction(),
      onChanged: (value) =>
          widget.onChange != null ? widget.onChange!(value) : null,
      // onEditingComplete: () => widget.searchAction(),
      controller: widget.searchController,
      style: Theme.of(context).textTheme.bodyLarge,

      decoration: InputDecorationWidget()
          .build(hint: 'search', prefixIcon: _buildSearchIcon()),
    );
  }

  IconButton _buildSearchIcon() {
    return IconButton(
      icon: Icon(Icons.search_outlined, color: Colors.white38),
      // Update the state i.e. toogle the state of passwordVisible variable
      onPressed: () => widget.searchAction(),
    );
  }
}
