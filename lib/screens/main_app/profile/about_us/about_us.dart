import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';
import 'package:tradeupapp/widgets/general/general_back_button.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButtonCustomGeneral(),
                    const Text(
                      'About Us',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/aboutus.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // 📱 Ứng dụng
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 240, 240, 240),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '📱 Ứng dụng SWAPIT',
                        style: TextStyle(
                          color: AppColors.header,
                          fontSize: 20,
                          fontFamily: 'Roboto-Black',
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Ứng dụng SWAPIT được phát triển như một phần của đồ án môn học nhằm nâng cao kỹ năng lập trình di động và xây dựng ứng dụng thực tế.',
                        style: TextStyle(
                          color: AppColors.header,
                          fontFamily: 'Roboto-Regular',
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),

                // 💡 Mục tiêu
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 240, 240, 240),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '💡 Mục tiêu:',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        '- Thiết kế một ứng dụng tiện ích, thân thiện với người dùng.\n'
                        '- Áp dụng các công nghệ hiện đại như Flutter & Firebase.',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),

                // 👥 Nhóm phát triển
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 240, 240, 240),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '👥 Nhóm phát triển:',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        '- Ngô Hoàng Nam – KTPM02.\n'
                        '- Lê Thành Phát – KTPM02.',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),

                // ⏳ Thời gian thực hiện
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 240, 240, 240),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '⏳ Thời gian thực hiện:',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Từ ngày 01/06/2025 đến ngày 15/07/2025.',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),

                // 🎯 Ý nghĩa
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 240, 240, 240),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '🎯 Ý nghĩa:',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Đây là sản phẩm đánh dấu quá trình học hỏi và thực hành trong suốt quá trình học tập. Nhóm mong muốn có thể cải thiện và mở rộng ứng dụng trong tương lai.',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),

                // ✨ Cảm ơn
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    '✨ Cảm ơn bạn đã sử dụng ứng dụng của chúng tôi!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
                      fontFamily: 'Roboto-MediumItalic',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
