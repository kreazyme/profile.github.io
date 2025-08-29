import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _rotationAnim = Tween<double>(begin: 0, end: 8 * 3.14159 / 180).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOutBack),
      ),
    );

    _scaleAnim = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOutCubic),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF7F4),
      body: Center(
        child: MouseRegion(
          onEnter: (_) {
            _controller.forward();
          },
          onExit: (_) {
            _controller.reverse();
          },
          child: AnimatedBuilder(
            animation: _rotationAnim,
            builder: (context, child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateZ(_rotationAnim.value)
                  ..scale(_scaleAnim.value),
                child: child,
              );
            },
            child: _ProfileItem(),
          ),
        ),
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  const _ProfileItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with GitHub icon and social links
          Row(
            children: [
              const Icon(Icons.account_circle, size: 24),
              const SizedBox(width: 8),
              const Text(
                "kreazyme/README.md",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'monospace',
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.link, color: Color(0xFF0077B5)),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.photo_camera, color: Color(0xFFE1306C)),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Profile content
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "hi, im spoon.dev",
                style: TextStyle(fontFamily: 'monospace', fontSize: 15),
              ),
              SizedBox(height: 12),
              Text(
                "Flutter Developer",
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 15,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "+ 🏃 living in Da nang, vietnam",
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 15,
                  color: Colors.green,
                ),
              ),
              Text(
                "! 📍 from Nghi Xuan, Ha Tinh",
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 15,
                  color: Colors.orange,
                ),
              ),
              Text(
                "- 🎂 22 years old",
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 15,
                  color: Colors.purple,
                ),
              ),
              Text(
                "# 🎵 altrock, indie",
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              Text(
                "# 🎬 movie lover",
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Tech stack
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5FBF7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "<tech-stack>",
                  style: TextStyle(
                    color: Colors.green,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    FlutterLogo(size: 36),
                    SizedBox(width: 16),
                    Icon(Icons.code, size: 36, color: Colors.blue),
                    SizedBox(width: 16),
                    Icon(Icons.javascript, size: 36, color: Colors.amber),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  "</tech-stack>",
                  style: TextStyle(
                    color: Colors.green,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
