import 'package:flutter/material.dart';

class EmptyAppDropDownWidget extends StatelessWidget {
  const EmptyAppDropDownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(color: Theme.of(context).disabledColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<String>(
        items: [],
        underline: const SizedBox.shrink(),
        dropdownColor: Theme.of(context).cardColor,
        isExpanded: true,
        onChanged: (Object? value) {},
      ),
    );
  }
}
