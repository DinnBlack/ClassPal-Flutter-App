import 'package:flutter/material.dart';
import 'package:flutter_class_pal/utils/constants/constant.dart';
import 'package:flutter_class_pal/utils/ui_util/app_text_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomListItem extends StatefulWidget {
  final String? imageUrl;
  final String? title;
  final String? subtitle;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback? onTap;
  final IconData? leadingIcon;
  final bool? trailingIcon;

  const CustomListItem({
    super.key,
    this.imageUrl,
    this.title,
    this.subtitle,
    this.backgroundColor = kTransparentColor,
    this.textColor = Colors.black,
    this.onTap,
    this.leadingIcon,
    this.trailingIcon = false,
  });

  @override
  State<CustomListItem> createState() => _CustomListItemState();
}

class _CustomListItemState extends State<CustomListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    if (widget.onTap != null) {
      widget.onTap!();
    }
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: kPaddingMd),
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(kBorderRadiusMd),
              ),
              child: Row(
                children: [
                  // Image
                  if (widget.imageUrl != null)
                    ClipOval(
                      child: Padding(
                        padding: const EdgeInsets.all(kPaddingSm),
                        child: Image.asset(
                          widget.imageUrl!,
                          fit: BoxFit.cover,
                          width: 32,
                          height: 32,
                        ),
                      ),
                    ),
                  if (widget.imageUrl != null) const SizedBox(width: kMarginMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.title != null)
                          Text(
                            widget.title!,
                            style: AppTextStyle.semibold(
                              kTextSizeSm,
                            ),
                          ),
                        if (widget.subtitle != null)
                          Text(
                            widget.subtitle!,
                            style: AppTextStyle.light(
                              kTextSizeXs,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (widget.leadingIcon != null)
                    Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          widget.leadingIcon,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  const SizedBox(width: kMarginMd),
                  // Trailing icon
                  if (widget.trailingIcon!)
                    const FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: 16,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
