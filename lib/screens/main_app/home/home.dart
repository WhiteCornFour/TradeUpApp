import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/assets/colors/app_colors.dart';
import 'package:tradeupapp/models/category_model.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_button_group_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_category_group_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_product_card_vertical_widget.dart';
import 'package:tradeupapp/widgets/main_app_widgets/home_widgets/home_search_bar_and_filter.dart';
import 'package:tradeupapp/data/category_data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final List<CategoryModel> allCategories = categories;

  final PageController _pageController = PageController(viewportFraction: 0.92);
  int _currentPage = 0; //Update dot indicator index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome + Avatar + Wishlist
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.grey[300],
                          child: const Icon(Icons.person, color: Colors.black),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Welcome back, ',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontFamily: 'Roboto-Regular',
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Jonh Doe',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Roboto-Bold',
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black54, width: 1.5),
                      ),
                      child: IconButton(
                        icon: const Icon(Iconsax.bookmark),
                        color: Colors.black,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),

              //Stack Searching Group
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // Container Text + SearchBar
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 40,
                      bottom: 26,
                    ),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColors.header,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 170, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Explore and trade up to',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Roboto-Regular',
                                  height: 1.3,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '256 products',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 233, 205, 119),
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  height: 1.2,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'and find what you love!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Roboto-Regular',
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        const SearchBarAndFilterHome(),
                      ],
                    ),
                  ),

                  //Girl Image
                  Positioned(
                    top: -20,
                    left: -10,
                    child: SizedBox(
                      height: 184,
                      child: Image.asset(
                        'lib/assets/images/girl_white_shirt_holding_something.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),

              //Text: Find Your Favor
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 5,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Iconsax.category, color: Colors.black),
                    const SizedBox(width: 15),
                    const Text(
                      'Sort by Category',
                      style: TextStyle(fontSize: 20, fontFamily: 'Roboto-Bold'),
                    ),

                    const Spacer(),

                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: const [
                          Text(
                            'View all',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.background,
                              fontFamily: 'Roboto-Light',
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Color.fromARGB(255, 144, 182, 216),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //Pageview Category
              SizedBox(
                height: 210,
                child: PageView(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  pageSnapping: true,
                  children: [
                    CategoryGroupHome(
                      categories: allCategories.sublist(0, 3),
                      layoutType: 1,
                    ),
                    CategoryGroupHome(
                      categories: allCategories.sublist(3, 7),
                      layoutType: 2,
                    ),
                    CategoryGroupHome(
                      categories: allCategories.sublist(7, 11),
                      layoutType: 2,
                    ),
                    CategoryGroupHome(
                      categories: allCategories.sublist(11, 14),
                      layoutType: 3,
                    ),
                  ],
                ),
              ),

              //Dot Indicator
              SizedBox(
                height: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 12 : 8,
                      height: _currentPage == index ? 12 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? AppColors.background
                            : Colors.grey[400],
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 20),

              //Text: Discover
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 5,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Iconsax.ticket_star, color: Colors.black),
                    const SizedBox(width: 15),
                    const Text(
                      'Discover',
                      style: TextStyle(fontSize: 20, fontFamily: 'Roboto-Bold'),
                    ),

                    const Spacer(),

                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: const [
                          Text(
                            'View all',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.background,
                              fontFamily: 'Roboto-Light',
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Color.fromARGB(255, 144, 182, 216),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              //Combo Button
              ButtonGroupHome(),

              SizedBox(height: 15),

              //GridView Products
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  padding: EdgeInsetsGeometry.zero,
                  itemCount: 4,
                  shrinkWrap: true,
                  physics:
                      NeverScrollableScrollPhysics(), //vo hieu cuon cua GridView vi nam trong ScrollView
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    mainAxisExtent: 288,
                    childAspectRatio: 0.8,
                  ),

                  itemBuilder: (_, index) => ProductCardVerticalHome(),
                ),
              ),

              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
