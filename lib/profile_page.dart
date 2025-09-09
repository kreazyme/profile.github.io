import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
  bool isPressed = false;
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _rotationAnim = Tween<double>(begin: 0, end: 6 * 3.14159 / 180).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOutBack),
      ),
    );

    _scaleAnim = Tween<double>(begin: 1.0, end: 1.05).animate(
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
    final backgroundColor = isDarkMode ? Colors.black87 : Colors.yellow.shade50;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final appBar = AppBar(
      backgroundColor: backgroundColor,
      actions: [
        Text('Dark Mode', style: TextStyle(color: textColor)),
        const SizedBox(width: 4),
        Switch(
          value: isDarkMode,
          thumbIcon: WidgetStateProperty.fromMap({
            WidgetState.selected: Icon(Icons.dark_mode),
            WidgetState.any: Icon(Icons.light_mode),
          }),
          thumbColor: WidgetStateProperty.fromMap({
            WidgetState.selected: Colors.white,
            WidgetState.any: Colors.black,
          }),
          trackColor: WidgetStateProperty.fromMap({
            WidgetState.selected: Colors.black,
            WidgetState.any: Colors.white,
          }),
          trackOutlineColor: WidgetStateProperty.fromMap({
            WidgetState.selected: Colors.white60,
            WidgetState.any: Colors.black54,
          }),
          onChanged: (value) => setState(() => isDarkMode = !isDarkMode),
        ),
      ],
    );
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar,
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
            child: GestureDetector(
              onTap: () {
                if (isPressed) {
                  _controller.reverse();
                } else {
                  _controller.forward();
                }
                isPressed = !isPressed;
              },
              child: _ProfileItem(isDarkMode),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  _ProfileItem(this.isDarkMode);

  final bool isDarkMode;

  final font = GoogleFonts.firaMono(fontSize: 14);

  void openMail() {
    launchUrlString('mailto:spoon.me.dev@gmail.com');
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final textColor = isDarkMode ? Colors.white70 : Colors.black87;
    return Container(
      width: 400,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black87 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode ? Colors.white : Colors.black,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundImage: AssetImage('assets/logo.png'),
              ),
              const SizedBox(width: 8),
              Text(
                "frame_it/README.md",
                style: font.copyWith(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.android_rounded, color: Colors.green),
                onPressed: () {
                  launchUrlString(
                    'https://play.google.com/store/apps/details?id=spoon.app.frame_it',
                  );
                },
              ),
              // IconButton(
              //   icon: const Icon(Icons.apple, color: Colors.grey),
              //   onPressed: () {
              //     showDialog(
              //       context: context,
              //       builder: (context) => AlertDialog(
              //         title: Text('We are in developing!'),
              //         content: Text(
              //           'We are developing day by day to deliver iOS app. Thank to waiting for us',
              //         ),
              //         actions: [
              //           FilledButton(
              //             onPressed: () {
              //               Navigator.pop(context);
              //             },
              //             child: Text('Ok'),
              //           ),
              //         ],
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
          const SizedBox(height: 8),
          // Profile content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi, we are frame_it team",
                style: font.copyWith(color: textColor),
              ),
              SizedBox(height: 4),
              Text(
                "We created awesome pictures with frames",
                style: font.copyWith(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              _TextItem(
                text: '% 📍 live in danang, vietnam 🇻🇳',
                color: Colors.green,
              ),
              _TextItem(
                text: '^ 🧑‍💻 we built app with flutter',
                color: Colors.red,
              ),
              _TextItem(
                text: '& 🎂 ${now.year - 2001} years old',
                color: Colors.indigo,
              ),
              _TextItem(text: '# 📸 we took pictures', color: Colors.pink),
              _TextItem(text: '! 🤑 money lover', color: Colors.teal),
            ],
          ),
          const SizedBox(height: 12),
          // Tech stack
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Colors.blueGrey.shade900
                  : Colors.pink.shade100.withAlpha(50),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "<team-members>",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    _MemberItem(
                      imagePath: 'assets/profile/fe.jpg',
                      roleName: 'FrontendDev',
                      isDarkMode: isDarkMode,
                    ),
                    _MemberItem(
                      imagePath: 'assets/profile/mo.jpg',
                      roleName: 'MobileDev',
                      isDarkMode: isDarkMode,
                    ),
                    _MemberItem(
                      imagePath: 'assets/profile/be.jpg',
                      roleName: 'BackendDev',
                      isDarkMode: isDarkMode,
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    _MemberItem(
                      imagePath: 'assets/profile/mkt.jpg',
                      roleName: 'Marketing',
                      isDarkMode: isDarkMode,
                    ),
                    _MemberItem(
                      imagePath: 'assets/profile/pm.jpg',
                      roleName: 'ProjectMan',
                      isDarkMode: isDarkMode,
                    ),
                    _MemberItem(
                      imagePath: 'assets/profile/des.jpg',
                      roleName: 'Designer',
                      isDarkMode: isDarkMode,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  "</team-members>",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.purple.shade100,
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text.rich(
              textAlign: TextAlign.start,
              TextSpan(
                children: [
                  const TextSpan(text: 'Hello me at '),
                  TextSpan(
                    text: '@my_email',
                    recognizer: TapGestureRecognizer()..onTap = openMail,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TextItem extends StatelessWidget {
  const _TextItem({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color.withValues(alpha: 0.2),
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
      padding:
          const EdgeInsets.all(1) + const EdgeInsets.only(right: 8, left: 4),
      child: Text(text, style: TextStyle(fontSize: 13, color: color)),
    );
  }
}

class _MemberItem extends StatelessWidget {
  const _MemberItem({
    required this.imagePath,
    required this.roleName,
    required this.isDarkMode,
  });

  final String imagePath;
  final String roleName;
  final bool isDarkMode;

  void onTap(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Member profile',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 2,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(imagePath)),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 8),
            Text('Full name: Tran Duc'),
            Text('City: Da Nang, Viet Nam'),
            Text('Age: ${DateTime.now().year - 2001}'),
            Text('Role: $roleName'),
          ],
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Ok'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => onTap(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(radius: 28, backgroundImage: AssetImage(imagePath)),
            const SizedBox(height: 8),
            Text(
              roleName,
              style: TextStyle(
                fontSize: 12,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
