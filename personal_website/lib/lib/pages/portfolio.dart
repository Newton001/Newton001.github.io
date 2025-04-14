import 'package:flutter/material.dart';
import 'package:personal_website/custom_drawer.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(title: Text('Portfolio')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('RFID Gym Management System', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('A complete gym entry system with RFID card reader, SD storage, and LCD interface.'),
            SizedBox(height: 16),
            Text('Medical Robotics Sensor Fusion', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Sensor fusion for IMU and optical data in robotic-assisted surgery.'),
          ],
        ),
      ),
    );
  }
}
