import 'package:flutter/material.dart';

class CustomSwitchWidget extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const CustomSwitchWidget({required this.value, this.onChanged});

  @override
  _CustomSwitchWidgetState createState() => _CustomSwitchWidgetState();
}

class _CustomSwitchWidgetState extends State<CustomSwitchWidget> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _value = !_value;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(_value);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 45,
        height: 22,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: _value
              ? Theme.of(context).primaryColor
              : Theme.of(context).primaryColorLight,
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              top: 2,
              left: _value ? 30 : 2,
              right: _value ? 2 : 30,
              bottom: 2,
              child: Container(
                width: 24,
                height: 26,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).cardColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
