import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final List<String> mediaItems = [
    'assets/images/design1.png',
    'assets/images/design2.png',
    'assets/videos/demo1.mp4',
    'assets/videos/demo2.mp4',
  ];

  final List<VideoPlayerController?> _videoControllers = [];
  final List<ChewieController?> _chewieControllers = [];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  bool _isSubmitting = false;
  bool _showSuccess = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoControllers();
  }

  void _initializeVideoControllers() {
    for (String item in mediaItems) {
      if (item.endsWith('.mp4')) {
        final videoController = VideoPlayerController.asset(item);
        final chewieController = ChewieController(
          videoPlayerController: videoController,
          looping: true,
          autoPlay: false,
          showControls: true,
        );
        _videoControllers.add(videoController);
        _chewieControllers.add(chewieController);
        videoController.initialize();
      } else {
        _videoControllers.add(null);
        _chewieControllers.add(null);
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _chewieControllers) {
      controller?.dispose();
    }
    for (var controller in _videoControllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  void _launch(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
        _showSuccess = false;
      });

      final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
      const serviceId = 'your_service_id';
      const templateId = 'your_template_id';
      const userId = 'your_user_id';

      final response = await http.post(
        url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_name': _nameController.text,
            'user_email': _emailController.text,
            'user_message': _messageController.text,
          },
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _isSubmitting = false;
          _showSuccess = true;
        });
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to send message')),
        );
        setState(() => _isSubmitting = false);
      }

      await Future.delayed(const Duration(seconds: 3));
      setState(() => _showSuccess = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Contact Me', style: GoogleFonts.poppins(color: Colors.orangeAccent)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/about'),
            child: const Text('About', style: TextStyle(color: Colors.orangeAccent)),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/portfolio'),
            child: const Text('Portfolio', style: TextStyle(color: Colors.orangeAccent)),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF0A0E21),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: isMobile
              ? Column(
                  children: [_buildMediaSection(), const SizedBox(height: 20), _buildFormSection()],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: _buildMediaSection()),
                    const SizedBox(width: 30),
                    Expanded(flex: 2, child: _buildFormSection()),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildMediaSection() {
    return SizedBox(
      height: 500,
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: mediaItems.length,
        itemBuilder: (context, index) {
          final isVideo = mediaItems[index].endsWith('.mp4');
          if (isVideo) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Chewie(controller: _chewieControllers[index]!),
            );
          } else {
            return MouseRegion(
              onEnter: (_) => setState(() {}),
              onExit: (_) => setState(() {}),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(mediaItems[index]),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orangeAccent.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildFormSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Text("Let's Get in Touch",
              style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
          const SizedBox(height: 20),
          _contactTile(Icons.email, 'Email', 'Newtonkelvin75@gmail.com', () => _launch('mailto:Newtonkelvin75@gmail.com')),
          _contactTile(Icons.code, 'GitHub', 'github.com/Newton001', () => _launch('https://github.com/Newton001')),
          _contactTile(Icons.person, 'LinkedIn', 'linkedin.com/in/newtonkelvin', () => _launch('https://linkedin.com/in/newtonkelvin')),
          _contactTile(Icons.web, 'Website', 'velkine.me', () => _launch('http://velkine.me')),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Column(
              children: [
                _textField(_nameController, 'Your Name', false),
                const SizedBox(height: 12),
                _textField(_emailController, 'Your Email', false, isEmail: true),
                const SizedBox(height: 12),
                _textField(_messageController, 'Your Message', true),
                const SizedBox(height: 20),
                _isSubmitting
                    ? const CircularProgressIndicator(color: Colors.orangeAccent)
                    : ElevatedButton.icon(
                        onPressed: _submitForm,
                        icon: const Icon(Icons.send),
                        label: const Text('Send Message'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                if (_showSuccess)
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Text('✅ Message sent successfully!',
                        key: const ValueKey("success"),
                        style: GoogleFonts.poppins(color: Colors.greenAccent, fontSize: 16)),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => _launch('https://1drv.ms/b/s!AmCMhkKwKW_ioI9gHq1SRvyMpgQQ3g?e=9E7CVm'),
            icon: const Icon(Icons.download),
            label: const Text('Download My CV'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactTile(IconData icon, String label, String value, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.orangeAccent),
      title: Text(label, style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14)),
      subtitle: Text(value, style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500)),
      onTap: onTap,
    );
  }

  Widget _textField(TextEditingController controller, String label, bool isMultiline, {bool isEmail = false}) {
    return TextFormField(
      controller: controller,
      maxLines: isMultiline ? 4 : 1,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white38),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.orangeAccent),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return '$label is required';
        if (isEmail && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'Enter a valid email';
        return null;
      },
    );
  }
}
