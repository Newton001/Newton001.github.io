import 'package:flutter/material.dart';
import 'package:personal_website/custom_drawer.dart';

class DocumentationPage extends StatelessWidget {
  const DocumentationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(title: Text('Documentation')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Technical documentation will be available soon. Contact me if you want a draft or specific repo docs.'),
      ),
    );
  }
}
