// Updated with autoplay transition indicator and hover overlay for videos
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'custom_drawer.dart';

class Project {
  final String title;
  final String description;
  final String repoUrl;
  final String imagePath;
  final String category;

  Project({
    required this.title,
    required this.description,
    required this.repoUrl,
    required this.imagePath,
    required this.category,
  });
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final List<Project> projects = [
    Project(
      title: 'RFID Gym Management System',
      description: 'A complete gym entry system with RFID, SD logging, and LCD feedback.',
      repoUrl: 'https://github.com/Newton001/RFID-Gym-Access-System',
      imagePath: 'assets/images/rfid_gym.png',
      category: 'Embedded',
    ),
    Project(
      title: '3D Object Volume Calculator',
      description: 'Qt/QML tool for calculating object volumes from parameters.',
      repoUrl: 'https://github.com/Newton001/3D-Object-Volume-Calculator',
      imagePath: 'assets/images/volume_calculator.png',
      category: 'Desktop',
    ),
    Project(
      title: 'Multi-Sensor IoT System',
      description: 'Sensor data collection system with STM32 + wireless data sync.',
      repoUrl: 'https://github.com/Newton001/Multi-Sensor-IoT-System',
      imagePath: 'assets/images/iot_system.png',
      category: 'IoT',
    ),
    Project(
      title: 'Rust Embedded on STM32',
      description: 'Firmware using Rust RTIC + HAL for STM32 boards.',
      repoUrl: 'https://github.com/Newton001/Rust-Embedded-STM32-Microcontrollers',
      imagePath: 'assets/images/rust_stm32.png',
      category: 'Rust',
    ),
  ];

  final categories = ['All', 'Embedded', 'IoT', 'Rust', 'Desktop'];
  String selectedCategory = 'All';
  int currentPage = 0;

  void _launch(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  void _nextPage() {
    setState(() {
      currentPage = (currentPage + 1) % filteredProjects.length;
    });
  }

  void _prevPage() {
    setState(() {
      currentPage = (currentPage - 1 + filteredProjects.length) % filteredProjects.length;
    });
  }

  List<Project> get filteredProjects => selectedCategory == 'All'
      ? projects
      : projects.where((p) => p.category == selectedCategory).toList();

  @override
  Widget build(BuildContext context) {
    final currentProject = filteredProjects[currentPage];

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Portfolio', style: GoogleFonts.poppins(color: Colors.orangeAccent)),
      ),
      backgroundColor: const Color(0xFF0A0E21),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'My Projects',
                style: GoogleFonts.poppins(
                    fontSize: 34, fontWeight: FontWeight.bold, color: Colors.orangeAccent),
              ).animate().fadeIn(duration: 500.ms).slideY(),
            ),
            const SizedBox(height: 20),
            Center(
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: categories.map((cat) => FilterChip(
                      label: Text(cat),
                      selected: selectedCategory == cat,
                      onSelected: (_) {
                        setState(() {
                          selectedCategory = cat;
                          currentPage = 0;
                        });
                      },
                      selectedColor: Colors.orangeAccent,
                      backgroundColor: const Color(0xFF1C2233),
                      labelStyle: TextStyle(
                          color: selectedCategory == cat ? Colors.black : Colors.white70,
                          fontWeight: FontWeight.w500),
                    )).toList(),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 600),
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(begin: const Offset(0.2, 0), end: Offset.zero)
                          .animate(animation),
                      child: child,
                    ),
                  ),
                  child: _projectCard(context, currentProject, key: ValueKey(currentProject.title)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.orangeAccent),
                  onPressed: _prevPage,
                ),
                Text(
                  '${currentPage + 1} / ${filteredProjects.length}',
                  style: GoogleFonts.poppins(color: Colors.white70),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, color: Colors.orangeAccent),
                  onPressed: _nextPage,
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () => _launch('https://1drv.ms/b/s!AmCMhkKwKW_ioI9gHq1SRvyMpgQQ3g?e=9E7CVm'),
                  icon: const Icon(Icons.download, color: Colors.orangeAccent),
                  label: Text('Download CV', style: GoogleFonts.poppins(color: Colors.orangeAccent)),
                ),
                TextButton.icon(
                  onPressed: () => Navigator.pushNamed(context, '/about'),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  label: Text('About', style: GoogleFonts.poppins(color: Colors.white)),
                ),
                TextButton.icon(
                  onPressed: () => Navigator.pushNamed(context, '/documentation'),
                  icon: const Icon(Icons.arrow_forward, color: Colors.white),
                  label: Text('Documentation', style: GoogleFonts.poppins(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );

  }

  Widget _projectCard(BuildContext context, Project project, {Key? key}) {
    bool isHovered = false;

    return StatefulBuilder(
      key: key,
      builder: (context, setHoverState) => MouseRegion(
        onEnter: (_) => setHoverState(() => isHovered = true),
        onExit: (_) => setHoverState(() => isHovered = false),
        child: GestureDetector(
          onTap: () => _launch(project.repoUrl),
          child: Animate(
            effects: const [FadeEffect(), SlideEffect(begin: Offset(0, 0.2))],
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width > 800 ? 700 : double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF121B30), Color(0xFF0A0E21)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orangeAccent.withOpacity(0.2),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      )
                    ],
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(project.imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(project.title,
                                  style: GoogleFonts.poppins(
                                      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
                              const SizedBox(height: 8),
                              Text(project.description,
                                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70)),
                              const SizedBox(height: 12),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton.icon(
                                  onPressed: () => _launch(project.repoUrl),
                                  icon: const Icon(Icons.code, size: 16, color: Colors.orangeAccent),
                                  label: Text('GitHub',
                                      style: GoogleFonts.poppins(
                                          color: Colors.orangeAccent,
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.underline)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isHovered)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.4),
                      child: const Center(
                        child: Icon(Icons.play_circle_fill, size: 64, color: Colors.orangeAccent),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
