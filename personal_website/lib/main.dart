
import 'package:flutter/material.dart';
import 'package:personal_website/about.dart';
import 'package:personal_website/home.dart';
import 'package:personal_website/contact.dart';
import 'package:personal_website/lib/pages/documentation.dart';
import 'package:personal_website/portfolio.dart';

void main() {
  runApp(const EmbeddedResumeApp());
}

class EmbeddedResumeApp extends StatelessWidget {
  const EmbeddedResumeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Newton Ollengo | Embedded Systems Engineer',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
        primaryColor: const Color.fromARGB(255, 0, 2, 11),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/about': (context) => const AboutPage(),
        '/portfolio': (context) => const PortfolioPage(),
        '/documentation': (context) => const DocumentationPage(),
        '/contact': (context) => const ContactPage(),
      },
    );
  }
}
