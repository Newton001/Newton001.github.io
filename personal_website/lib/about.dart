import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  void _launch(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  bool isWide = true;
  bool isEnglish = true;

  @override
  Widget build(BuildContext context) {
    isWide = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: MediaQuery.of(context).size.width <= 800
            ? Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : null,
        actions: MediaQuery.of(context).size.width > 800
            ? [
                _navButton(context, label: '← Home', route: '/'),
                _navButton(context, label: 'Next →', route: '/portfolio'),
                _langToggle(),
              ]
            : [_langToggle()],
      ),
      drawer: MediaQuery.of(context).size.width <= 800
          ? Drawer(
              backgroundColor: const Color(0xFF121B30),
              child: ListView(
                children: [
                  DrawerHeader(
                    child: Text("Menu", style: GoogleFonts.poppins(color: Colors.orangeAccent)),
                  ),
                  ListTile(
                    title: const Text("Home", style: TextStyle(color: Colors.white)),
                    onTap: () => Navigator.pushNamed(context, '/'),
                  ),
                  ListTile(
                    title: const Text("Portfolio", style: TextStyle(color: Colors.white)),
                    onTap: () => Navigator.pushNamed(context, '/portfolio'),
                  ),
                ],
              ),
            )
          : null,
      body: Stack(
        children: [
          _backgroundOrbs(),
          _mainContent(context),
        ],
      ),
    );
  }

  Widget _navButton(BuildContext context, {required String label, required String route}) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, route),
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }

  Widget _langToggle() {
    return IconButton(
      tooltip: 'Switch Language',
      icon: const Icon(Icons.language, color: Colors.orangeAccent),
      onPressed: () => setState(() => isEnglish = !isEnglish),
    );
  }

  Widget _backgroundOrbs() {
    return Stack(
      children: [
        Positioned(top: 80, left: 50, child: _blurredCircle(160, Colors.orangeAccent.withOpacity(0.2))),
        Positioned(bottom: 100, right: 40, child: _blurredCircle(200, Colors.white.withOpacity(0.05))),
        Positioned(top: 200, right: 100, child: _blurredCircle(100, Colors.lightBlueAccent.withOpacity(0.08))),
      ],
    );
  }

  Widget _mainContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            children: [
              _profileHeader(),
              const SizedBox(height: 40),
              _animatedSection("Core Competencies"),
              _skillGroup("Software", ["C, C++, Rust, Python", "RTOS / Baremetal", "Secure Bootloaders"]),
              _skillGroup("Hardware", ["Embedded Systems Dev", "Firmware Architecture", "Hardware Design & Debugging"]),
              _skillGroup("Integration", ["QML / Qt Integration", "IoT & Wireless Comms", "STM32, PSoC6, Zephyr"]),
              const SizedBox(height: 40),
              _animatedSection("Work Experience"),
              _educationCard("Embedded Systems Engineer", "SurgeonsLab AG / ARTORG Center for Biomedical Engineering Research, Bern, Switzerland", "2022 - Present"),
              _educationCard("Electronics Engineer Intern", "ARTORG Center for Biomedical Engineering Research, Bern", "2021"),
              _educationCard("Electronics Engineer | Researcher", "ICT Authority, Nairobi", "2020"),
              const SizedBox(height: 40),
              _animatedSection("Education"),
              _educationCard("MSc Biomedical Engineering", "University of Bern, Switzerland", "2023 - Present"),
              _educationCard("BSc Electrical and Electronics Engineering", "Dedan Kimathi University of Technology, Kenya", "2025 - Present"),
              _educationCard("BEd Tech Electrical and Electronics", "Dedan Kimathi University of Technology, Kenya", "2017 - 2021"),
              _educationCard("KCSE", "Alliance High School, Kenya", "2013 - 2016"),
              const SizedBox(height: 40),
              _animatedSection("Certifications & Extras"),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _chip("Embedded Linux Professional Training"),
                  _chip("Public Speaking – Toastmasters Nairobi"),
                  _chip("English, Kiswahili, Dholuo, Luhya, German"),
                  _chip("Cycling, Tech Blogging, Running"),
                ],
              ),
              const SizedBox(height: 40),
              _animatedSection("Featured Project"),
              _projectCard(
                title: "RFID Gym Access System",
                tools: "STM32, MFRC522, SD, LCD, ADC, SPI",
                summary: "A secure, low-power gym access system using RFID tags and embedded interface with buzzer + SD logging.",
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/portfolio'),
                child: Text(
                  "Explore all projects →",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.orangeAccent,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _animatedSection(String title) => Animate(
        effects: [FadeEffect(), SlideEffect(begin: const Offset(0, 0.1))],
        child: _section(title),
      );

  Widget _profileHeader() {
    return Animate(
      effects: [FadeEffect(), SlideEffect(begin: const Offset(0, 0.2))],
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white.withOpacity(0.05), Colors.white.withOpacity(0.02)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.orangeAccent.withOpacity(0.15),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Flex(
            direction: isWide ? Axis.horizontal : Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: isWide ? 80 : 60,
                backgroundImage: const AssetImage('assets/images/newton_1.jpg'),
              ).animate().fadeIn().slideY(begin: 0.2),
              const SizedBox(width: 24, height: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                  children: [
                    Text("An Engineer with a Vision",
                        style: GoogleFonts.poppins(
                            fontSize: 28, fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
                    const SizedBox(height: 12),
                    Text(
                      isEnglish
                          ? "I'm Newton Ollengo, a Biomedical and Embedded Systems Engineer with a unique dual background in hardware electronics and firmware engineering. From designing complex circuit boards to building secure, real-time embedded software, I create robust tech solutions that drive innovation and improve lives."
                          : "Ich bin Newton Ollengo, ein Biomedizin- und Embedded-Systems-Ingenieur mit einem einzigartigen Hintergrund in Hardware- und Firmwareentwicklung. Ich entwickle robuste technische Lösungen, die Innovationen fördern und Leben verbessern.",
                      style: GoogleFonts.poppins(fontSize: 16, color: Colors.white70),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _iconButton("LinkedIn", Icons.link, 'https://www.linkedin.com/in/newtonkelvin/'),
                        _iconButton("GitHub", Icons.code, 'https://github.com/Newton001'),
                        _iconButton("Download CV", Icons.download, 'assets/CV_NewtonKelvin.pdf'),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _blurredCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }

  Widget _chip(String label) {
    return Chip(
      label: Text(label, style: const TextStyle(color: Colors.orangeAccent)),
      backgroundColor: const Color(0xFF1C2233),
      shape: StadiumBorder(
        side: BorderSide(color: Colors.orangeAccent.withOpacity(0.4)),
      ),
    );
  }

  Widget _section(String title) {
    return Text(title,
        style: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.orangeAccent,
        ));
  }

  Widget _skillGroup(String title, List<String> skills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(title, style: GoogleFonts.poppins(fontSize: 18, color: Colors.white)),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: skills.map(_chip).toList(),
        ),
      ],
    );
  }

  Widget _educationCard(String title, String institution, String duration) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title,
            style: GoogleFonts.poppins(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500)),
        subtitle: Text("$institution\n$duration",
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.white60)),
      ),
    );
  }

  Widget _projectCard({required String title, required String tools, required String summary}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      color: const Color(0xFF121B30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.orangeAccent)),
            const SizedBox(height: 6),
            Text(tools,
                style: GoogleFonts.poppins(
                    fontSize: 14, color: Colors.white54)),
            const SizedBox(height: 8),
            Text(summary,
                style: GoogleFonts.poppins(
                    fontSize: 14, color: Colors.white70)),
          ],
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.3);
  }

  Widget _iconButton(String label, IconData icon, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ElevatedButton.icon(
        onPressed: () => _launch(url),
        icon: Icon(icon, size: 18),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orangeAccent.withOpacity(0.1),
          foregroundColor: Colors.orangeAccent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ).animate().scaleXY(begin: 0.95, end: 1.0).fadeIn(duration: 500.ms),
    );
  }
}
