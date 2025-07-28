import 'package:flutter/material.dart';
import 'package:tradeupapp/constants/app_colors.dart';

class PostCardDescriptionShop extends StatefulWidget {
  final String text;
  final int maxLines;

  const PostCardDescriptionShop({
    super.key,
    required this.text,
    this.maxLines = 3,
  });

  @override
  State<PostCardDescriptionShop> createState() =>
      _PostCardDescriptionShopState();
}

class _PostCardDescriptionShopState extends State<PostCardDescriptionShop> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 14, fontFamily: 'Roboto-Regular');

    return LayoutBuilder(
      builder: (context, constraints) {
        final span = TextSpan(text: widget.text, style: textStyle);
        final tp = TextPainter(
          maxLines: widget.maxLines,
          textAlign: TextAlign.start,
          textDirection: TextDirection.ltr,
          text: span,
        )..layout(maxWidth: constraints.maxWidth);

        final isOverflowing = tp.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text,
              style: textStyle,
              maxLines: _isExpanded ? null : widget.maxLines,
              overflow: _isExpanded
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
            ),
            if (isOverflowing)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    _isExpanded ? 'View less' : 'View more...',
                    style: TextStyle(
                      color: AppColors.background,
                      fontSize: 14,
                      fontFamily: 'Roboto-Bold',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
