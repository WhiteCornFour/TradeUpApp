import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tradeupapp/screens/general/general_share_show_bottom_sheet.dart';
import 'package:tradeupapp/screens/main_app/chat/controllers/chat_room_controller.dart';
import 'package:tradeupapp/screens/main_app/chat/controllers/message_controller.dart';
import 'package:tradeupapp/screens/main_app/shop/controllers/shop_controller.dart';

class PostCardBottomShop extends StatefulWidget {
  const PostCardBottomShop({
    super.key,
    required this.likeCount,
    required this.userId,
    required this.userName,
    required this.productId,
    required this.likedBy,
  });

  final int likeCount;
  final String? userId, userName;
  final String productId;
  final List<String> likedBy;

  @override
  State<PostCardBottomShop> createState() => _PostCardBottomShopState();
}

class _PostCardBottomShopState extends State<PostCardBottomShop> {
  final shopController = Get.find<ShopController>();
  final chatRoomController = ChatRoomController.instance;

  @override
  void initState() {
    super.initState();
    chatRoomController.searchController.addListener(() {
      chatRoomController.filterChatRoomsByNameAndTagname(
        chatRoomController.searchController.text,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final shopController = Get.find<ShopController>();
    String? currentUserId = shopController.currentUserId.value;
    //Kiểm tra xem người dùng hiện tại có nằm trong danh sách người like bài viết
    final bool isLiked = widget.likedBy.contains(currentUserId);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Like + Comment
          Row(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () async {                    
                      if (widget.userId == null) return;

                      if (isLiked) {
                        await shopController.unlikeProduct(
                          widget.productId,
                          currentUserId,
                        );
                      } else {
                        await shopController.likeProduct(
                          widget.productId,
                          currentUserId,
                        );
                        await shopController.addLikeProductNotification(productOwnerId: widget.userId!, currentUserId: currentUserId, productId: widget.productId);
                      }
                    },
                    icon: Icon(
                      isLiked ? Iconsax.heart5 : Iconsax.heart,
                      color: isLiked ? Colors.red : Colors.black,
                    ),
                    tooltip: isLiked ? 'Unlike' : 'Like',
                  ),
                  SizedBox(width: 4),
                  Text(
                    '${widget.likeCount} Likes',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(width: 16),
              // IconButton(
              //   onPressed: () {},
              //   icon: const Icon(Iconsax.messages_3),
              //   color: Colors.black,
              //   tooltip: 'Comment',
              // ),
            ],
          ),

          //Share + Wishlist
          Row(
            children: [
              IconButton(
                onPressed: () {
                  shopController.handleCheckOrStartChat(
                    widget.userId!,
                    context,
                    widget.userName ?? 'User not Availabel',
                  );
                },
                icon: Icon(Iconsax.messages_3),
                color: Colors.black,
                tooltip: 'Contact',
              ),
              IconButton(
                onPressed: () {
                  ShareShowBottomSheetGeneral.show(
                    context,
                    chatRoomController.filteredChatRooms,
                    chatRoomController.searchController,
                    chatRoomController.isLoading.value,
                    (idChatRoom) {
                      MessageController().handleSendProduct(
                        widget.productId,
                        idChatRoom,
                      );
                    },
                  );
                },
                icon: Icon(Icons.share),
                color: Colors.black,
                tooltip: 'Share',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
