import 'package:flutter/material.dart';

class TitleFieldWidget extends StatelessWidget {
  final String title;
  final bool isRequired;

  const TitleFieldWidget({
    Key? key,
    this.title = '',
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(fontSize: 15),
            ),
            if (isRequired) // add * shape if this field required
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 4),
                child: Text('*',
                    style: Theme.of(context).primaryTextTheme.headlineSmall),
              ),
          ],
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }
}
