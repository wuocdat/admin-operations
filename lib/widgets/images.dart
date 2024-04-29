import 'package:flutter/material.dart';

class DemoAvatar extends StatelessWidget {
  const DemoAvatar({super.key, this.size = 50});

  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size),
      child: Image.network(
        'https://images.unsplash.com/photo-1611590027211-b954fd027b51?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDd8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=900&q=60',
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }
}
