import 'package:flutter/material.dart';
import 'package:tradeupapp/widgets/general/general_back_button.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  Widget _buildInfoCard(String title, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            content,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  const BackButtonCustomGeneral(),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'About Us',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Để cân bằng với BackButton
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/aboutus.jpg',
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildInfoCard(
                '📱 SWAPIT App',
                'The SWAPIT app was developed as part of a course project to improve mobile programming skills and build a practical application.',
              ),
              _buildInfoCard(
                '💡 Goals',
                '- Design a user-friendly and useful application.\n'
                    '- Apply modern technologies such as Flutter & Firebase.',
              ),
              _buildInfoCard(
                '👥 Development Team',
                '- Ngo Hoang Nam – KTPM02.\n'
                    '- Le Thanh Phat – KTPM02.',
              ),
              _buildInfoCard(
                '⏳ Project Duration',
                'From June 1, 2025 to July 15, 2025.',
              ),
              _buildInfoCard(
                '🎯 Purpose',
                'This product marks the learning and practice process throughout the study journey. Our team hopes to improve and expand the application in the future.',
              ),
              const SizedBox(height: 8),
              const Text(
                '✨ Thank you for using our application!',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
