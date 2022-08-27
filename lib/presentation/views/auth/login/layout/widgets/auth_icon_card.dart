import 'package:flutter/material.dart';

class AuthIconCard extends StatelessWidget {
  const AuthIconCard({
    Key? key,
    required this.imagePath,
  }) : super(key: key);
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: 33,
        width: 33,
        padding: const EdgeInsets.all(8),
        child: Image(
          image: AssetImage(imagePath),
        ),
      ),
    );
  }
}
