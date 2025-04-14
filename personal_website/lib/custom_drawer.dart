import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Text(
              'Newton Ollengo',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(title: const Text('Home'), onTap: () => Navigator.pushNamed(context, '/')),
          ListTile(title: const Text('About'), onTap: () => Navigator.pushNamed(context, '/about')),
          ListTile(title: const Text('Portfolio'), onTap: () => Navigator.pushNamed(context, '/portfolio')),
          ListTile(title: const Text('Documentation'), onTap: () => Navigator.pushNamed(context, '/documentation')),
          ListTile(title: const Text('Contact'), onTap: () => Navigator.pushNamed(context, '/contact')),
        ],
      ),
    );
  }
}
