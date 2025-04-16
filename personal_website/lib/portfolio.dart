import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';

class Project {
  final String title;
  final String description;
  final String repoUrl;
  final String mediaPath;
  final String category;

  Project({
    required this.title,
    required this.description,
    required this.repoUrl,
    required this.mediaPath,
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
      mediaPath: 'assets/images/Saleae_logic_analyzer_ouput.png',
      category: 'Embedded',
    ),
    Project(
      title: '3D Object Volume Calculator',
      description: 'Qt/QML tool for calculating object volumes from parameters.',
      repoUrl: 'https://github.com/Newton001/3D-Object-Volume-Calculator',
      mediaPath: 'assets/images/volume_calc.png',
      category: 'Desktop',
    ),
    Project(
      title: 'Multi-Sensor IoT System',
      description: 'Sensor data collection system with STM32 + wireless data sync.',
      repoUrl: 'https://github.com/Newton001/Multi-Sensor-IoT-System',
      mediaPath: 'assets/images/iot_system.png',
      category: 'IoT',
    ),
    Project(
      title: 'Rust Embedded on STM32',
      description: 'Firmware using Rust RTIC + HAL for STM32 boards.',
      repoUrl: 'https://github.com/Newton001/Rust-Embedded-STM32-Microcontrollers',
      mediaPath: 'assets/images/saleae_logic_analyzer_ouput.png',
      category: 'Rust',
    ),
  ];

  final List<String> categories = ['All', 'Embedded', 'Desktop', 'IoT', 'Rust'];
  String selectedCategory = 'All';
  int currentIndex = 0;
  Timer? _autoplayTimer;

  List<Project> get filteredProjects =>
      selectedCategory == 'All'
          ? projects
          : projects.where((p) => p.category == selectedCategory).toList();

  void _launch(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  void _nextSlide() {
    setState(() {
      currentIndex = (currentIndex + 1) % filteredProjects.length;
    });
  }

  void _restartAutoplay() {
    _autoplayTimer?.cancel();
    _autoplayTimer = Timer.periodic(const Duration(seconds: 6), (_) => _nextSlide());
  }

  @override
  void initState() {
    super.initState();
    _restartAutoplay();
  }

  @override
  void dispose() {
    _autoplayTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width > 700;
    final projectsToShow = filteredProjects;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: TextButton(
          onPressed: () => Navigator.pushNamed(context, '/about'),
          child: const Text('← About', style: TextStyle(color: Colors.white)),
        ),
        centerTitle: true,
        title: Text(
          'Portfolio',
          style: GoogleFonts.poppins(
            color: Colors.orangeAccent,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/contact'),
            child: const Text('Next →', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'My Projects',
                      style: GoogleFonts.poppins(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent),
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
                                currentIndex = 0;
                                _restartAutoplay();
                              });
                            },
                            selectedColor: Colors.orangeAccent,
                            backgroundColor: const Color(0xFF1C2233),
                            labelStyle: TextStyle(
                                color: selectedCategory == cat
                                    ? Colors.black
                                    : Colors.white70,
                                fontWeight: FontWeight.w500),
                          )).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            sliver: SliverGrid(
              key: ValueKey(selectedCategory + currentIndex.toString()),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isWide ? 2 : 1,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1.3,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ProjectCard(
                    project: projectsToShow[index],
                    onLaunch: _launch,
                  );
                },
                childCount: projectsToShow.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final Project project;
  final Function(String url) onLaunch;
  const ProjectCard({super.key, required this.project, required this.onLaunch});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;
  bool isVideo(String path) => path.toLowerCase().endsWith('.mp4');

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () => widget.onLaunch(widget.project.repoUrl),
        child: Animate(
          effects: const [FadeEffect(), SlideEffect(begin: Offset(0, 0.2))],
          child: Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: isVideo(widget.project.mediaPath)
                      ? VideoPreview(assetPath: widget.project.mediaPath)
                      : Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(widget.project.mediaPath),
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
                      Text(widget.project.title,
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.orangeAccent)),
                      const SizedBox(height: 8),
                      Text(widget.project.description,
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: Colors.white70)),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          onPressed: () => widget.onLaunch(widget.project.repoUrl),
                          icon: const Icon(Icons.code,
                              size: 16, color: Colors.orangeAccent),
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
      ),
    );
  }
}

class VideoPreview extends StatefulWidget {
  final String assetPath;
  const VideoPreview({super.key, required this.assetPath});

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.assetPath)
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : const Center(child: CircularProgressIndicator());
  }
}
