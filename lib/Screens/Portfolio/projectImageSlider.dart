import 'package:flutter/material.dart';

class ProjectImageSlider extends StatefulWidget {
  final List<String> images;

  const ProjectImageSlider({super.key, required this.images});

  @override
  State<ProjectImageSlider> createState() => _ProjectImageSliderState();
}

class _ProjectImageSliderState extends State<ProjectImageSlider> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Stack(
      children: [
        Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isMobile ? double.infinity : 900,
              maxHeight: isMobile ? 500 : 600,
            ),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: PageView.builder(
                controller: _controller,
                itemCount: widget.images.length,
                onPageChanged: (i) => setState(() => currentIndex = i),
                itemBuilder: (_, index) {
                  return InteractiveViewer(
                    minScale: 1,
                    maxScale: 3,
                    child: Image.asset(
                      widget.images[index],
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),
          ),
        ),

        /// CLOSE BUTTON
        Positioned(
          top: 20,
          right: 20,
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.white, size: 28),
            onPressed: () => Navigator.pop(context),
          ),
        ),

        /// LEFT ARROW (WEB)
        if (widget.images.length > 1)
          Positioned(
            left: 10,
            child: _navButton(Icons.chevron_left, () {
              _controller.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }),
          ),

        /// RIGHT ARROW (WEB)
        if (widget.images.length > 1)
          Positioned(
            right: 10,
            child: _navButton(Icons.chevron_right, () {
              _controller.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }),
          ),

        /// INDICATOR
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.images.length,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: currentIndex == i ? 10 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: currentIndex == i
                      ? Colors.blueAccent
                      : Colors.white38,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _navButton(IconData icon, VoidCallback onTap) {
    return Center(
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 40),
        onPressed: onTap,
      ),
    );
  }
}
