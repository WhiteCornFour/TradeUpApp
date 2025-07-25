import 'package:flutter/material.dart';
import 'package:tradeupapp/widgets/system_widgets/system_icon_widget.dart';

class BookmarkedToggleButtonSystem extends StatefulWidget {
  const BookmarkedToggleButtonSystem({
    super.key,
    this.initialState = false,
    this.onChanged,
  });

  final bool initialState;
  final ValueChanged<bool>? onChanged;

  @override
  State<BookmarkedToggleButtonSystem> createState() =>
      _BookmarkedToggleButtonSystemState();
}

class _BookmarkedToggleButtonSystemState
    extends State<BookmarkedToggleButtonSystem>
    with SingleTickerProviderStateMixin {
  late bool isBookmarked;

  @override
  void initState() {
    super.initState();
    isBookmarked = widget.initialState;
  }

  void _toggleBookmark() {
    setState(() => isBookmarked = !isBookmarked);
    widget.onChanged?.call(isBookmarked);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleBookmark,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeOutBack,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: IconSystem(
          width: 48,
          height: 48,
          key: ValueKey<bool>(isBookmarked),
          icon: isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
          color: isBookmarked ? Colors.white : const Color(0xFFFF6F61),
          backgroundColor: isBookmarked
              ? const Color(0xFFFF6F61)
              : Colors.white,
          borderColor: const Color(0xFFFF6F61),
          borderWidth: 1.5,
        ),
      ),
    );
  }
}
