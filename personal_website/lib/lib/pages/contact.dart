import 'package:flutter/material.dart';
import 'package:personal_website/custom_drawer.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(title: Text('Contact')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: Newtonkelvin75@gmail.com'),
            SizedBox(height: 8),
            Text('GitHub: github.com/Newton001'),
            SizedBox(height: 8),
            Text('LinkedIn: linkedin.com/in/newtonkelvin'),
            SizedBox(height: 8),
            Text('Website: velkine.me'),
          ],
        ),
      ),
    );
  }
}
