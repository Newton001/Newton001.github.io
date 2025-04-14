import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  void _launch(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/'),
            child: const Text('← Home', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/portfolio'),
            child: const Text('Next →', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Blurred Orbs
          Positioned(top: 80, left: 50, child: _blurredCircle(160, Colors.orangeAccent.withOpacity(0.2))),
          Positioned(bottom: 100, right: 40, child: _blurredCircle(200, Colors.white.withOpacity(0.05))),
          Positioned(top: 200, right: 100, child: _blurredCircle(100, Colors.lightBlueAccent.withOpacity(0.08))),

          // Main Content
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Column(
                  crossAxisAlignment: isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                  children: [
                    Animate(
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
                              color: Colors.orangeAccent.withOpacity(0.25),
                              blurRadius: 24,
                              spreadRadius: 2,
                              offset: const Offset(0, 10),
                            )
                          ],
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: isWide ? 80 : 60,
                                backgroundImage: const AssetImage('assets/images/newton.jpg'),
                              ).animate().fadeIn().slideY(begin: 0.2),
                              const SizedBox(width: 24),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                                  children: [
                                    Text("An Engineer with a Vision",
                                        style: GoogleFonts.poppins(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orangeAccent)),
                                    const SizedBox(height: 12),
                                    Text(
                                      "I'm Newton Ollengo, a Biomedical and Embedded Systems Engineer with a unique dual background in hardware electronics and firmware engineering. From designing complex circuit boards to building secure, real-time embedded software, I create robust tech solutions that drive innovation and improve lives.",
                                      style: GoogleFonts.poppins(fontSize: 16, color: Colors.white70),
                                    ),
                                    const SizedBox(height: 16),
                                    Wrap(
                                      spacing: 12,
                                      runSpacing: 12,
                                      children: [
                                        _iconButton(
                                          label: "LinkedIn",
                                          icon: Icons.link,
                                          url: 'https://www.linkedin.com/in/newtonkelvin/',
                                        ),
                                        _iconButton(
                                          label: "GitHub",
                                          icon: Icons.code,
                                          url: 'https://github.com/Newton001',
                                        ),
                                        _iconButton(
                                          label: "Download CV",
                                          icon: Icons.download,
                                          url: 'assets/CV_NewtonKelvin.pdf',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    _section("Core Competencies"),
                    _skillGroup("Software", [
                      "C, C++, Rust, Python",
                      "RTOS / Baremetal",
                      "Secure Bootloaders",
                    ]),
                    _skillGroup("Hardware", [
                      "Embedded Systems Dev",
                      "Firmware Architecture",
                      "Hardware Design & Debugging",
                    ]),
                    _skillGroup("Integration", [
                      "QML / Qt Integration",
                      "IoT & Wireless Comms",
                      "STM32, PSoC6, Zephyr",
                    ]),
                    const SizedBox(height: 40),
                    _section("Work Experience"),
                    _educationCard(
                      title: "Embedded Systems Engineer",
                      institution: "SurgeonsLab AG / ARTORG Center for Biomedical Engineering Research, Bern, Switzerland",
                      duration: "2022 - Present",
                    ),
                    _educationCard(
                      title: "Electronics Engineer Intern",
                      institution: "ARTORG Center for Biomedical Engineering Research, Bern",
                      duration: "2021",
                    ),
                    _educationCard(
                      title: "Electronics Engineer | Researcher",
                      institution: "ICT Authority, Nairobi",
                      duration: "2020",
                    ),
                    const SizedBox(height: 40),
                    _section("Education"),
                    _educationCard(
                      title: "MSc Biomedical Engineering",
                      institution: "University of Bern, Switzerland",
                      duration: "2023 - Present",
                    ),
                    _educationCard(
                      title: "BSc Electrical and Electronics Engineering",
                      institution: "Dedan Kimathi University of Technology, Kenya",
                      duration: "2025 - Present",
                    ),
                    _educationCard(
                      title: "BEd Tech Electrical and Electronics",
                      institution: "Dedan Kimathi University of Technology, Kenya",
                      duration: "2017 - 2021",
                    ),
                    _educationCard(
                      title: "Kenya Certificate of Secondary Education (KCSE)",
                      institution: "Alliance High School, Kenya",
                      duration: "2013 - 2016",
                    ),
                    const SizedBox(height: 40),
                    _section("Certifications & Extras"),
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
                    _section("Featured Project"),
                    _projectCard(
                      title: "RFID Gym Access System",
                      tools: "STM32, MFRC522, SD, LCD, ADC, SPI",
                      summary:
                          "A secure, low-power gym access system using RFID tags and embedded interface with buzzer + SD logging.",
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
          ),
        ],
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

  Widget _educationCard({
    required String title,
    required String institution,
    required String duration,
  }) {
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

  Widget _projectCard({
    required String title,
    required String tools,
    required String summary,
  }) {
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

  Widget _iconButton({required String label, required IconData icon, required String url}) {
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
