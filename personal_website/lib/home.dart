import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'custom_drawer.dart';
import 'footer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _backgroundColor;
  Offset _mouseOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat(reverse: true);

    _backgroundColor = TweenSequence<Color?>([
      TweenSequenceItem(
        tween: ColorTween(begin: const Color(0xFF0A0E21), end: const Color(0xFF1D2A46)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: const Color(0xFF1D2A46), end: const Color(0xFF121B30)),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: const Color(0xFF121B30), end: const Color(0xFF0A0E21)),
        weight: 1,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _reactiveCard({required Widget child}) {
    return MouseRegion(
      onHover: (event) => setState(() => _mouseOffset = event.localPosition),
      onExit: (_) => setState(() => _mouseOffset = Offset.zero),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()
          ..translate((_mouseOffset.dx - 150) * 0.01, (_mouseOffset.dy - 100) * 0.01)
          ..scale(1.03),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white.withOpacity(0.06),
          border: Border.all(color: Colors.orangeAccent.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.orangeAccent.withOpacity(0.4),
              blurRadius: 30,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _actionButton(BuildContext context, String label, String route) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: OutlinedButton.icon(
        onPressed: () => Navigator.pushNamed(context, route),
        icon: const Icon(Icons.arrow_forward_ios, size: 14),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.orangeAccent),
          foregroundColor: Colors.orangeAccent,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          shape: const StadiumBorder(),
        ).copyWith(
          overlayColor: MaterialStateProperty.all(Colors.orange.withOpacity(0.1)),
        ),
      ),
    );
  }

  Widget _downloadCVButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: OutlinedButton.icon(
        onPressed: () => launchUrl(Uri.parse('https://1drv.ms/b/s!AmCMhkKwKW_ioI9gHq1SRvyMpgQQ3g?e=9E7CVm')),
        icon: const Icon(Icons.file_download),
        label: const Text("Download CV"),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.orangeAccent),
          foregroundColor: Colors.orangeAccent,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          shape: const StadiumBorder(),
        ).copyWith(
          overlayColor: MaterialStateProperty.all(Colors.orange.withOpacity(0.1)),
        ),
      ),
    );
  }

  Widget _navButton(BuildContext context, String label, String route) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TextButton.icon(
        onPressed: () => Navigator.pushNamed(context, route),
        style: TextButton.styleFrom(foregroundColor: Colors.white),
        icon: const Icon(Icons.circle, size: 6),
        label: Text(label, style: GoogleFonts.poppins(fontSize: 14)),
      ),
    );
  }

  Widget _introCard(BuildContext context, bool isWide) {
    return _reactiveCard(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: isWide ? 80 : 60,
              backgroundImage: const AssetImage('assets/images/newton_1.jpg'),
            ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),
            const SizedBox(height: 20),
            Text("Hi, I'm", style: GoogleFonts.poppins(fontSize: 24, color: Colors.orangeAccent)),
            Text("Newton Ollengo", style: GoogleFonts.poppins(fontSize: 42, fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
            const SizedBox(height: 16),
            Text("Biomedical and Embedded\nSystems Engineer",
              style: GoogleFonts.poppins(fontSize: 22, color: Colors.white70),
              textAlign: isWide ? TextAlign.left : TextAlign.center),
            const SizedBox(height: 12),
            Text("I build smart medical\nand IoT solutions.",
              style: GoogleFonts.poppins(fontSize: 18, color: Colors.white60),
              textAlign: isWide ? TextAlign.left : TextAlign.center),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.orangeAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.work_outline, color: Colors.orangeAccent, size: 16),
                  const SizedBox(width: 6),
                  Text("Open to opportunities",
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.orangeAccent, fontWeight: FontWeight.w500)),
                ],
              ),
            ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3),
            const SizedBox(height: 30),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: [
                _actionButton(context, 'About', '/about'),
                _actionButton(context, 'Portfolio', '/portfolio'),
                _actionButton(context, 'Contact', '/contact'),
                _downloadCVButton(),
              ],
            ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.4),
          ],
        ),
      ),
    );
  }

  Widget _floatingFeatureBlock(bool isWide) {
    return _reactiveCard(
      child: Padding(
        padding: const EdgeInsets.all(34),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('My Expertise', style: GoogleFonts.poppins(fontSize: 28, color: Colors.orangeAccent, fontWeight: FontWeight.w600)),
            const SizedBox(height: 40),
            Wrap(
              spacing: 30,
              runSpacing: 30,
              alignment: WrapAlignment.center,
              children: [
                _skillCard('Medical Imaging', 'assets/images/medical_imaging.jpg'),
                _skillCard('Embedded Systems', 'assets/images/embedded.jpg'),
                _skillCard('Signal Processing', 'assets/images/signals.jpg'),
                _skillCard('Software Development', 'assets/images/software.png'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _skillCard(String title, String assetPath) {
    return _reactiveCard(
      child: Container(
        width: 180,
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(assetPath, height: 120, width: 120, fit: BoxFit.cover),
            ),
            const SizedBox(height: 28),
            Text(title,
              style: GoogleFonts.poppins(color: Colors.white70, fontSize: 15),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _missionBlock() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Driven by Purpose',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.orangeAccent,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'I combine engineering with empathy to craft impactful biomedical solutions. '
            'Whether building embedded firmware or signal processing, my goal is to bridge innovation with care.',
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _techTags() {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: [
          Chip(label: Text('Machine Learning'), backgroundColor: Colors.orange.withOpacity(0.1), labelStyle: const TextStyle(color: Colors.orange)),
          Chip(label: Text('Embedded Software'), backgroundColor: Colors.orange.withOpacity(0.1), labelStyle: const TextStyle(color: Colors.orange)),
          Chip(label: Text('Schematic and PCB Design'), backgroundColor: Colors.orange.withOpacity(0.1), labelStyle: const TextStyle(color: Colors.orange)),
          Chip(label: Text('Software Development'), backgroundColor: Colors.orange.withOpacity(0.1), labelStyle: const TextStyle(color: Colors.orange)),
          Chip(label: Text('Signal Processing'), backgroundColor: Colors.orange.withOpacity(0.1), labelStyle: const TextStyle(color: Colors.orange)),
        ],
      ),
    );
  }

 

  Widget _finalCTA(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Text("Let's create something meaningful.",
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
          const SizedBox(height: 12),
          _actionButton(context, 'Get in Touch', '/contact'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          //drawer: const CustomDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Newton Ollengo',
              style: GoogleFonts.poppins(
                color: Colors.orangeAccent,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            actions: [
              _navButton(context, 'About', '/about'),
              _navButton(context, 'Portfolio', '/portfolio'),
              _navButton(context, 'Contact', '/contact'),
            ],
          ),
          body: ScrollConfiguration(
            behavior: const BouncyScrollBehavior(),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _backgroundColor.value ?? const Color(0xFF0A0E21),
                      (_backgroundColor.value ?? const Color(0xFF0A0E21)).withOpacity(0.95),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 140),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final isWide = constraints.maxWidth > 800;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                            child: Flex(
                              direction: isWide ? Axis.horizontal : Axis.vertical,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: _introCard(context, isWide)),
                                const SizedBox(width: 40, height: 40),
                                Expanded(child: _floatingFeatureBlock(isWide)),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    _missionBlock(),
                    _techTags(),
                    //_featuredProject(),
                    _finalCTA(context),
                    const Footer(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class BouncyScrollBehavior extends ScrollBehavior {
  const BouncyScrollBehavior();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => const BouncingScrollPhysics();
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) => child;}