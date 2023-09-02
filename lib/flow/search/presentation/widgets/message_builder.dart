import 'package:flutter/material.dart';

class MessageBuilder extends StatelessWidget {
  const MessageBuilder({
    super.key,
    required this.messageBuilder,
    required this.child,
  });

  final String Function() messageBuilder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final message = messageBuilder();
    // To place message in the center of the screen regardless of other widgets
    return Stack(
      alignment: Alignment.center,
      children: [
        if (message.isNotEmpty)
          Text(
            message,
            style: Theme.of(context).textTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
        child,
      ],
    );
  }
}
