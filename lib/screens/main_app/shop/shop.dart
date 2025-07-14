import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/screens/main_app/shop/shop_product_detail.dart';
import 'package:tradeupapp/widgets/main_app_widgets/shop_widgets/shop_post_card_widget.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _Shop();
}

class _Shop extends State<Shop> {
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
              //Search button + Text: Market + Wishlist
              Padding(
                padding: EdgeInsets.only(
                  left: 30,
                  right: 25,
                  top: 20,
                  bottom: 20,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Feeds',
                      style: TextStyle(
                        fontFamily: 'Roboto-Bold',
                        fontSize: 26,
                        height: 1.0,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Iconsax.search_normal),
                          color: Colors.black,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Iconsax.menu_1),
                          color: Colors.black,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Iconsax.shop),
                          color: Colors.black,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //List of Post Card
              //Post card
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    PostCardShop(
                      onPressed: () => Get.to(() => ProductDetailShop()),
                      imageUrls: [
                        'lib/assets/images/sample_images/sample2.jpg',
                        'lib/assets/images/sample_images/sample3.jpg',
                        'lib/assets/images/sample_images/sample4.jpg',
                      ],
                      description:
                          'JBL Flip 6 is a portable waterproof speaker with bold sound. '
                          '\nWith its racetrack-shaped driver, this speaker delivers high output and booming bass. '
                          '\nIt features PartyBoost for pairing multiple speakers and has up to 12 hours of battery life. '
                          '\nContact throug bio.',
                      userName: 'Kathe Timber',
                      userAvatar:
                          'https://media.istockphoto.com/id/1317804578/photo/one-businesswoman-headshot-smiling-at-the-camera.jpg?s=612x612&w=0&k=20&c=EqR2Lffp4tkIYzpqYh8aYIPRr-gmZliRHRxcQC5yylY=',
                      timeAgo: '1 minute ago',
                      likeCount: 123,
                    ),

                    PostCardShop(
                      onPressed: () => {print('Post card tap')},
                      imageUrls: ['lib/assets/images/sample_images/sample.png'],
                      description:
                          'This is my old laptop but still use very good. If you want it you can contact with me.',
                      userName: 'John Doe',
                      userAvatar:
                          'https://images.unsplash.com/photo-1633332755192-727a05c4013d?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D',
                      timeAgo: '2 hours ago',
                      likeCount: 517,
                    ),
                  ],
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
