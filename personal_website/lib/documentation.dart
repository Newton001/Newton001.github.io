import 'package:flutter/material.dart';
import 'custom_drawer.dart';

class DocumentationPage extends StatelessWidget {
  const DocumentationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(title: const Text('Documentation')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Technical documentation will be available soon. Contact me if you want a draft or specific repo docs.'),
      ),
    );
  }
}
