import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class AddProductProductDropdownMenuShop extends StatefulWidget {
  final String? selectedCondition;
  final ValueChanged<String> onChanged;

  const AddProductProductDropdownMenuShop({
    super.key,
    required this.selectedCondition,
    required this.onChanged,
  });

  @override
  State<AddProductProductDropdownMenuShop> createState() =>
      _AddProductProductDropdownMenuShopState();
}

class _AddProductProductDropdownMenuShopState
    extends State<AddProductProductDropdownMenuShop>
    with SingleTickerProviderStateMixin {
  //Đặt trạng thái cho cái Dropdown menu là đóng hay mở
  bool isOpen = false;

  //Animation controller cho mũi tên xoay
  late AnimationController _arrowAnimation;

  final conditions = [
    'Brand New',
    'Like New',
    'Refurbished',
    'Used - Good',
    'Used - Acceptable',
  ];

  // Khởi tạo animation controller cho mũi tên
  @override
  void initState() {
    super.initState();
    _arrowAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _arrowAnimation.dispose();
    super.dispose();
  }

  //Đổi trạng thái mở/đóng dropdown
  void toggleDropdown() {
    setState(() {
      isOpen = !isOpen;
      if (isOpen) {
        _arrowAnimation.forward(); // Mở -> xoay mũi tên lên
      } else {
        _arrowAnimation.reverse(); // Đóng -> xoay mũi tên xuống
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: toggleDropdown,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.selectedCondition ?? 'Select product condition',
                  style: TextStyle(
                    fontSize: 15,
                    color: widget.selectedCondition == null
                        ? Colors.grey
                        : Colors.black,
                  ),
                ),

                // Mũi tên xoay có animation
                RotationTransition(
                  turns: Tween(begin: 0.0, end: 0.5).animate(_arrowAnimation),
                  child: Icon(Icons.keyboard_arrow_down, size: 24),
                ),
              ],
            ),
          ),
        ),

        //Danh sách item với animation trượt
        ///AnimatedSize trong Flutter là một widget dùng để tự động animate (chuyển động mượt) khi kích thước con của nó thay đổi.
        AnimatedSize(
          duration: Duration(milliseconds: 200), //Thời gian animate
          curve: Curves.easeInOut, //Kiểu chuyển động
          child: isOpen
              ? Container(
                  margin: EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: conditions.map((condition) {
                      final isSelected = widget.selectedCondition == condition;
                      return InkWell(
                        onTap: () {
                          widget.onChanged(condition);
                          toggleDropdown();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isSelected //Trạng thái khi chọn
                                ? AppColors.background.withOpacity(0.08)
                                : Colors.transparent,
                            borderRadius: BorderRadius.vertical(
                              top: condition == conditions.first
                                  ? Radius.circular(12)
                                  : Radius.zero,
                              bottom: condition == conditions.last
                                  ? Radius.circular(12)
                                  : Radius.zero,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(child: Text(condition)),
                              if (isSelected)
                                Icon(
                                  Icons.check,
                                  size: 18,
                                  color: AppColors.background,
                                ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
