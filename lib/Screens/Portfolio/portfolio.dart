import 'package:ashish_portfolio/Screens/Portfolio/ProRecruiterTipsSection.dart';
import 'package:ashish_portfolio/Screens/Portfolio/hireMeCTA.dart';
import 'package:ashish_portfolio/Screens/Portfolio/projectImageSlider.dart';
import 'package:ashish_portfolio/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';
import 'package:visibility_detector/visibility_detector.dart';

import '../../models/projectsModel.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ashish App & Web app Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Montserrat',
        colorSchemeSeed: Colors.blueAccent,
      ),
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome>
    with TickerProviderStateMixin {
  final ScrollController _scroll = ScrollController();

  final GlobalKey heroKey = GlobalKey();
  final GlobalKey whatIDoKey = GlobalKey();
  final GlobalKey portfolioKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey testimonialKey = GlobalKey();
  final GlobalKey blogsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  int hoverIndex = -1;
  int hoverSkillIndex = -1;

  void scrollTo(GlobalKey key) {
    final c = key.currentContext;
    if (c == null) return;
    Scrollable.ensureVisible(c,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
        alignment: 0.12);
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _callMe() async {
    final uri = Uri.parse("tel:+918210297808");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _openWhatsApp() async {
    const phone = "918210297808"; // without +
    final whatsappUri = Uri.parse(
      "https://wa.me/$phone?text=Hi%20Ashish,%20I%20found%20your%20portfolio",
    );

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(
        whatsappUri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  // -------------------------------
  // UI BUILD
  // -------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131416),
      // Glassmorphism AppBar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: AppBar(
                backgroundColor: Colors.white.withOpacity(0.04),
                elevation: 0,
                title: const Text('Ashish Tiwari',
                    style: TextStyle(fontWeight: FontWeight.w700)),
                actions: Responsive.isDesktop(context)
                    ? [
                        _navBtn('What I Do', whatIDoKey),
                        _navBtn('Skills', skillsKey),
                        _navBtn('Portfolio', portfolioKey),
                        _navBtn('Contact', contactKey),
                        const SizedBox(width: 12),
                      ]
                    : [
                        IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (_) => mobileMenu(),
                            );
                          },
                        )
                      ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scroll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heroSection(),
            sectionWrapper(whatIDoKey, 'What I Do', whatIDo()),
            SizedBox(height: 60),
            ProductionDeliverablesSection(),
            SizedBox(height: 60),
            sectionWrapper(portfolioKey, 'Portfolio', portfolioSection()),
            sectionWrapper(experienceKey, 'Experience', experienceSection()),
            sectionWrapper(skillsKey, 'Skills', skillsSection()),
            sectionWrapper(
                testimonialKey, 'Testimonials', testimonialsPlaceholder()),
            sectionWrapper(blogsKey, 'Blogs', blogsPlaceholder()),
            sectionWrapper(contactKey, 'Connect', contactSection()),
            HireMeCTA(
              onCallTap: _callMe,
              onWhatsAppTap: _openWhatsApp,
            ),
            footer(),
          ],
        ),
      ),
    );
  }

  Widget _navBtn(String text, GlobalKey key) {
    return TextButton(
      onPressed: () => scrollTo(key),
      child: Text(text, style: const TextStyle(color: Colors.white70)),
    );
  }

  Widget heroSection() {
    final isMobile = Responsive.isMobile(context);

    return Container(
      key: heroKey,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 60,
        vertical: isMobile ? 32 : 48,
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _heroText(isMobile),
                const SizedBox(height: 28),
                ParallaxImage(
                  imgPath: 'assets/ashish_fhd.png',
                  width: 260,
                  height: 300,
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _heroText(isMobile)),
                const SizedBox(width: 40),
                ParallaxImage(
                  imgPath: 'assets/ashish_fhd.png',
                  width: 380,
                  height: 430,
                ),
              ],
            ),
    );
  }

  Widget _heroText(bool isMobile) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 700),
      builder: (context, v, child) {
        return Opacity(
          opacity: v,
          child: Transform.translate(
            offset: Offset(0, (1 - v) * 18),
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment:
            isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          RichText(
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Hi, I'm ",
                  style: TextStyle(
                    fontSize: isMobile ? 32 : 48,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                  ),
                ),
                TextSpan(
                  text: "Ashish Tiwari",
                  style: TextStyle(
                    fontSize: isMobile ? 32 : 48,
                    fontWeight: FontWeight.w800,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Hybrid Mobile Developer",
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
            style: TextStyle(
              fontSize: isMobile ? 18 : 22,
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            " With 3.5+ years of experience building scalable Flutter apps for Android, iOS & Web. Specialized in"
            "performance, clean UI, and real-world API integrations.",
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
            style: TextStyle(
              fontSize: 15,
              height: 1.6,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget heroText(bool isMobile) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 700),
      builder: (context, v, child) {
        return Opacity(
          opacity: v,
          child: Transform.translate(
            offset: Offset(0, (1 - v) * 18),
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Hi, I'm ",
                  style: TextStyle(
                    fontSize: isMobile ? 32 : 48,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                  ),
                ),
                TextSpan(
                  text: "Ashish Tiwari",
                  style: TextStyle(
                    fontSize: isMobile ? 32 : 48,
                    fontWeight: FontWeight.w800,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Hybrid Mobile Developer",
            style: TextStyle(
              fontSize: isMobile ? 18 : 22,
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            "Passionate Hybrid Mobile Developer with 3.5+ years of experience "
            "building high-performance apps for Android, iOS & Web using Flutter & Dart. "
            "Skilled in GetX, Provider, Firebase, REST APIs, secure authentication, "
            "offline storage, and clean architecture.\n\n"
            "I focus on creating modern, scalable, and user-centric applications with "
            "smooth UI/UX, optimized performance, and maintainable code. "
            "Open to Full-Time, Remote, Contractual & Freelance opportunities.",
            style: TextStyle(
              fontSize: isMobile ? 14.5 : 16,
              height: 1.6,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 22),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.download, color: Colors.black),
            label: const Text(
              "Download CV",
              style: TextStyle(color: Colors.black),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 18 : 22,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 12,
            children: [
              socialIcon(FontAwesomeIcons.linkedin,
                  "https://www.linkedin.com/in/ashish-tiwari-2a4a7018b/"),
              socialIcon(FontAwesomeIcons.github, "https://github.com/"),
              socialIcon(FontAwesomeIcons.envelope,
                  "mailto:aashishtiwari.cse@gmail.com"),
              socialIcon(FontAwesomeIcons.phone, "tel:+918210297808"),
            ],
          ),
        ],
      ),
    );
  }

  Widget heroImage(bool isMobile) {
    return ParallaxImage(
      imgPath: 'assets/ashish_fhd.png',
      width: isMobile ? 260 : 380,
      height: isMobile ? 320 : 430,
    );
  }

  Widget mobileMenu() {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          mobileNav('What I Do', whatIDoKey),
          mobileNav('Skills', skillsKey),
          mobileNav('Portfolio', portfolioKey),
          mobileNav('Contact', contactKey),
        ],
      ),
    );
  }

  Widget mobileNav(String title, GlobalKey key) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        scrollTo(key);
      },
    );
  }

  Widget socialIcon(IconData icon, String url) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: IconButton(
        icon: FaIcon(icon, color: Colors.white, size: 28),
        onPressed: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
      ),
    );
  }

  // ---------------- SECTION WRAPPER with ScrollFade ----------------
  Widget sectionWrapper(GlobalKey key, String title, Widget content) {
    return Container(
      key: key,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isMobile(context) ? 16 : 60,
        vertical: Responsive.isMobile(context) ? 32 : 48,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 18),
          ScrollFade(child: content),
        ],
      ),
    );
  }

  // ---------------- WHAT I DO ----------------
  Widget whatIDo() {
    return Column(
      children: [
        cardTile("Mobile App Development",
            "High-performance Flutter apps used by 10K+ real users on Android & iOS & Web App"),
        const SizedBox(height: 18),
        cardTile("API Integration",
            "Scalable REST APIs with Firebase & payment gateways — reduced API latency by 30%"),
        const SizedBox(height: 18),
        cardTile("UI/UX Engineering",
            "Pixel-perfect, responsive UI with smooth navigation & UX best practices"),
        cardTile("Architecture & State Management",
            "Clean Architecture with GetX & Provider for scalable, testable apps"),
      ],
    );
  }

  Widget cardTile(String title, String description) {
    return MouseRegion(
      onEnter: (_) => setState(() {}),
      onExit: (_) => setState(() {}),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 240),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.blueAccent.withOpacity(0.06),
                blurRadius: 12,
                spreadRadius: 1),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.blueAccent, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(description,
                        style: const TextStyle(color: Colors.white60)),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- PORTFOLIO ----------------

  Widget portfolioSection() {
    final projects = [
      Project(images: [
        'assets/iPhone 13 Pro.png',
        'assets/track.png',
        'assets/trackk.png'
      ]),
      Project(
          images: ['assets/Pemaxx.png', 'assets/pemx.png', 'assets/pemax.png']),
      Project(images: [
        'assets/ezt.jpeg',
        'assets/ezymart.jpeg',
        'assets/ezym.jpeg',
      ]),
      Project(images: [
        'assets/food.jpeg',
        'assets/food1.jpeg',
        'assets/food2.jpeg',
      ]),
      Project(images: [
        'assets/service.jpeg',
        'assets/service1.jpeg',
        'assets/service2.jpeg',
      ]),
      Project(images: [
        'assets/mart.jpeg',
        'assets/mart2.jpeg',
        'assets/mart1.jpeg'
      ]),
    ];

    return animatedPortfolioGrid(projects);
  }

  void showProjectPreview(BuildContext context, List<String> images) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: ProjectImageSlider(images: images),
      ),
    );
  }

  Widget animatedPortfolioGrid(List<Project> projects) {
    final isMobile = Responsive.isMobile(context);
    final isDesktop = Responsive.isDesktop(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: projects.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 1 : 2,
        crossAxisSpacing: isMobile ? 14 : 22,
        mainAxisSpacing: isMobile ? 14 : 18,
        childAspectRatio: isMobile ? 1.25 : 1.9,
      ),
      itemBuilder: (context, index) {
        final project = projects[index];
        final isHovered = hoverIndex == index;

        return Padding(
          padding: EdgeInsets.only(bottom: isMobile ? 16 : 40),
          child: GestureDetector(
            onTap: () => showProjectPreview(context, project.images),
            child: MouseRegion(
              onEnter:
                  isDesktop ? (_) => setState(() => hoverIndex = index) : null,
              onExit: isDesktop ? (_) => setState(() => hoverIndex = -1) : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 260),
                transform: isDesktop && isHovered
                    ? (Matrix4.identity()
                      ..translate(0, -8)
                      ..scale(1.03))
                    : Matrix4.identity(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    if (isDesktop && isHovered)
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.22),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Stack(
                    children: [
                      /// Thumbnail = FIRST IMAGE
                      Positioned.fill(
                        child: Image.asset(
                          project.images.first,
                          fit: BoxFit.contain,
                        ),
                      ),

                      /// Overlay
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: isDesktop ? (isHovered ? 0.18 : 0.0) : 0.08,
                        child: Container(color: Colors.black),
                      ),

                      /// Label
                      Positioned(
                        bottom: 12,
                        left: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Open Project',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ---------------- EXPERIENCE ----------------
  Widget experienceSection() {
    return Column(
      children: [
        experienceTile(
          "Flutter Developer",
          "3+ Years of Experience",
          "Cross-platform app development, state management, API integration.",
        ),
        experienceTile(
          "Mobile App UI/UX Developer",
          "3+ Years of Experience",
          "Responsive UI, animations, reusable components, design conversion.",
        ),
        experienceTile(
          "API Integration Specialist",
          "3+ Years of Experience",
          "REST APIs, file uploads, authentication, dashboard systems.",
        ),
      ],
    );
  }

  Widget experienceTile(String company, String role, String duration) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8),
      title: Text(company,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      subtitle: Text("$role · $duration",
          style: const TextStyle(color: Colors.white70)),
    );
  }

  // ---------------- SKILLS ----------------
  Widget skillsSection() {
    final coreSkills = [
      'Flutter',
      'Dart',
      'REST APIs',
      'WebSockets',
      'Responsive UI',
      'Animations',
      'Android App Development',
      'iOS App Development',
      'Web App Development',
    ];

    final stateManagement = [
      'GetX',
      'Bloc',
      'Provider',
      'Riverpod',
    ];

    final toolsTech = [
      'Firebase',
      'SQL/NoSQL',
      'Git & GitHub',
      'Clean Architecture',
      'Figma',
      'CI/CD',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle("Core Development"),
        animatedSkillChips(coreSkills),
        const SizedBox(height: 20),
        sectionTitle("State Management"),
        animatedSkillChips(stateManagement),
        const SizedBox(height: 20),
        sectionTitle("Tools & Technologies"),
        animatedSkillChips(toolsTech),
      ],
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget animatedSkillChips(List<String> skills) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: skills.asMap().entries.map((e) {
        final idx = e.key;
        final label = e.value;
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: Duration(milliseconds: 360 + idx * 80),
          builder: (context, v, child) {
            final hovered = hoverSkillIndex == idx;
            return Transform.scale(
              scale: hovered ? 1.06 * v : 1.0 * v,
              child: Opacity(
                opacity: v,
                child: MouseRegion(
                  onEnter: (_) => setState(() => hoverSkillIndex = idx),
                  onExit: (_) => setState(() => hoverSkillIndex = -1),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: hovered
                          ? Colors.blueAccent.withOpacity(0.22)
                          : Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.06)),
                    ),
                    child: Text(label,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  // ---------------- TESTIMONIALS & BLOGS ----------------
  Widget testimonialsPlaceholder() {
    return const Text("Testimonials coming soon...",
        style: TextStyle(color: Colors.white54));
  }

  Widget blogsPlaceholder() {
    return const Text("Blogs will be added soon",
        style: TextStyle(color: Colors.white54));
  }

  // ---------------- CONTACT ----------------
  Widget contactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("Email: aashishtiwari.cse@gmail.com"),
        SizedBox(height: 10),
        Text("Phone: +91 82102 97808"),
      ],
    );
  }

  // ---------------- FOOTER ----------------
  Widget footer() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      alignment: Alignment.center,
      child: const Text("© 2025 Ashish Tiwari",
          style: TextStyle(color: Colors.white54)),
    );
  }
}

// ---------------- PARALLAX IMAGE WIDGET ----------------
class ParallaxImage extends StatefulWidget {
  final String imgPath;
  final double width;
  final double height;

  const ParallaxImage(
      {super.key, required this.imgPath, this.width = 420, this.height = 490});

  @override
  State<ParallaxImage> createState() => _ParallaxImageState();
}

class _ParallaxImageState extends State<ParallaxImage> {
  double tiltX = 0;
  double tiltY = 0;

  void _onHover(PointerEvent event) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;
    final local = box.globalToLocal(event.position);
    final centerX = box.size.width / 2;
    final centerY = box.size.height / 2;
    setState(() {
      tiltX = (local.dx - centerX) / centerX;
      tiltY = (local.dy - centerY) / centerY;
    });
  }

  void _onExit(PointerEvent e) => setState(() {
        tiltX = 0;
        tiltY = 0;
      });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: _onHover,
      onExit: _onExit,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.width,
        height: widget.height,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blueAccent.shade400,
            Colors.purpleAccent.shade200
          ]),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
                color: Colors.blueAccent.withOpacity(0.18),
                blurRadius: 24,
                spreadRadius: 2)
          ],
        ),
        child: Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(tiltX * 0.08)
            ..rotateX(-tiltY * 0.08)
            ..translate(-tiltX * 6, -tiltY * 6),
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset(widget.imgPath, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

// ---------------- SCROLL FADE (visibility triggered) ----------------
class ScrollFade extends StatefulWidget {
  final Widget child;
  const ScrollFade({super.key, required this.child});

  @override
  State<ScrollFade> createState() => _ScrollFadeState();
}

class _ScrollFadeState extends State<ScrollFade>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  bool _visibleFired = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 650));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!_visibleFired && info.visibleFraction > 0.12) {
      _visibleFired = true;
      _ctrl.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(widget.child),
      onVisibilityChanged: _onVisibilityChanged,
      child: FadeTransition(
        opacity: _fade,
        child: SlideTransition(position: _slide, child: widget.child),
      ),
    );
  }
}
