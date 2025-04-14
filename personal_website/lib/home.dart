import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'custom_drawer.dart';
import 'footer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const CustomDrawer(),
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
          _navButton(context, 'Docs', '/documentation'),
          _navButton(context, 'Contact', '/contact'),
        ],
      ),
      body: ScrollConfiguration(
        behavior: const BouncyScrollBehavior(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: screenHeight,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF0A0E21), Color(0xFF121B30)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: 50,
                    child: _blurredCircle(150, Colors.orangeAccent.withOpacity(0.2)),
                  ),
                  Positioned(
                    bottom: 80,
                    right: 80,
                    child: _blurredCircle(200, Colors.white.withOpacity(0.05)),
                  ),
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1100),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final isWide = constraints.maxWidth > 700;
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 120),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.05),
                                  Colors.white.withOpacity(0.02),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.1),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.orangeAccent.withOpacity(0.3),
                                  blurRadius: 30,
                                  spreadRadius: 4,
                                  offset: const Offset(0, 12),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                                child: Padding(
                                  padding: const EdgeInsets.all(32),
                                  child: Flex(
                                    direction: isWide ? Axis.horizontal : Axis.vertical,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.orangeAccent.withOpacity(0.6),
                                              blurRadius: 30,
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          radius: isWide ? 110 : 80,
                                          backgroundImage:
                                              const AssetImage('assets/images/newton.jpg'),
                                        ),
                                      ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),

                                      const SizedBox(width: 40, height: 40),

                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment: isWide
                                              ? CrossAxisAlignment.start
                                              : CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Hi, I'm",
                                              style: GoogleFonts.poppins(
                                                fontSize: 24,
                                                color: Colors.orangeAccent,
                                              ),
                                            ),
                                            Text(
                                              "Newton Ollengo",
                                              style: GoogleFonts.poppins(
                                                fontSize: 42,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.orangeAccent,
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            Text(
                                              "Biomedical and Embedded\nSystems Engineer",
                                              style: GoogleFonts.poppins(
                                                fontSize: 22,
                                                color: Colors.white70,
                                              ),
                                              textAlign: isWide
                                                  ? TextAlign.left
                                                  : TextAlign.center,
                                            ),
                                            const SizedBox(height: 12),
                                            Text(
                                              "I build smart medical\nand IoT solutions.",
                                              style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                color: Colors.white60,
                                              ),
                                              textAlign: isWide
                                                  ? TextAlign.left
                                                  : TextAlign.center,
                                            ),
                                            const SizedBox(height: 20),
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 8),
                                              decoration: BoxDecoration(
                                                color: Colors.orangeAccent.withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              child: Text(
                                                "Open to opportunities",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color: Colors.orangeAccent,
                                                  fontWeight: FontWeight.w500,
                                                ),
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
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _blurredCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  static Widget _navButton(BuildContext context, String label, String route) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TextButton(
        onPressed: () => Navigator.pushNamed(context, route),
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(fontSize: 14),
        ),
      ),
    );
  }

  static Widget _actionButton(BuildContext context, String label, String route) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: OutlinedButton(
        onPressed: () => Navigator.pushNamed(context, route),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.orangeAccent),
          foregroundColor: Colors.orangeAccent,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          shape: const StadiumBorder(),
        ).copyWith(
          overlayColor: MaterialStateProperty.all(Colors.orange.withOpacity(0.1)),
        ),
        child: Text(label),
      ),
    );
  }

  static Widget _downloadCVButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: OutlinedButton(
        onPressed: () => launchUrl(Uri.parse('https://1drv.ms/b/s!AmCMhkKwKW_ioI9gHq1SRvyMpgQQ3g?e=9E7CVm')),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.orangeAccent),
          foregroundColor: Colors.orangeAccent,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          shape: const StadiumBorder(),
        ).copyWith(
          overlayColor: MaterialStateProperty.all(Colors.orange.withOpacity(0.1)),
        ),
        child: const Text("Download CV"),
      ),
    );
  }
}

// Add this class to enable bouncy scroll physics inside ScrollConfiguration
class BouncyScrollBehavior extends ScrollBehavior {
  const BouncyScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }

  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
