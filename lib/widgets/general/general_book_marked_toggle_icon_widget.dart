import 'package:flutter/material.dart';
import 'package:tradeupapp/widgets/general/general_icon_widget.dart';

class BookmarkedToggleButtonGeneral extends StatefulWidget {
  const BookmarkedToggleButtonGeneral({
    super.key,
    this.initialState = false,
    this.onChanged,
  });

  final bool initialState;
  final ValueChanged<bool>? onChanged;

  @override
  State<BookmarkedToggleButtonGeneral> createState() =>
      _BookmarkedToggleButtonGeneralState();
}

class _BookmarkedToggleButtonGeneralState
    extends State<BookmarkedToggleButtonGeneral>
    with SingleTickerProviderStateMixin {
  late bool isBookmarked;

  @override
  void initState() {
    super.initState();
    isBookmarked = widget.initialState;
  }

  @override
  void didUpdateWidget(covariant BookmarkedToggleButtonGeneral oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialState != widget.initialState) {
      isBookmarked = widget.initialState;
    }
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
        child: IconGeneral(
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
