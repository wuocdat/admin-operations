import 'package:flutter/material.dart';

class NotificationBell extends StatefulWidget {
  const NotificationBell({
    super.key,
    required this.count,
  });

  final int count;

  @override
  State<NotificationBell> createState() => _NotificationBellState();
}

class _NotificationBellState extends State<NotificationBell>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Badge(
        label: Text('${widget.count}'),
        isLabelVisible: widget.count > 0,
        backgroundColor: Theme.of(context).primaryColor,
        child: RotationTransition(
          turns: Tween(begin: 0.0, end: -.1)
              .chain(CurveTween(curve: Curves.elasticIn))
              .animate(_controller),
          child: const Icon(Icons.notifications_outlined),
        ),
      ),
      iconSize: 30,
      // color: theme.primaryColor,
    );
  }
}
