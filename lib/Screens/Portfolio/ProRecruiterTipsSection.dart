import 'package:flutter/material.dart';



class ProductionDeliverablesSection extends StatelessWidget {
  const ProductionDeliverablesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "What I Deliver in Production Apps",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Real-world impact, measurable performance, and scalable Flutter solutions.",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
      
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: const [
              _StatCard(
                icon: Icons.people_alt_rounded,
                title: "10K+ Active Users",
                subtitle:
                    "Production applications with real users, retention, and long-term scalability.",
              ),
              _StatCard(
                icon: Icons.speed_rounded,
                title: "30% Faster APIs",
                subtitle:
                    "Optimized REST APIs using caching, pagination, and performance profiling.",
              ),
              _StatCard(
                icon: Icons.security_rounded,
                title: "Enterprise-Grade Authentication",
                subtitle:
                    "Secure Firebase and token-based authentication with role-based access.",
              ),
              _StatCard(
                icon: Icons.phone_android_rounded,
                title: "True Cross-Platform",
                subtitle:
                    "Single Flutter codebase powering Android, iOS, and Web applications.",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blueAccent, size: 30),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
