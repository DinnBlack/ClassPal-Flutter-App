import 'package:flutter/material.dart';

import '../../constants/constant.dart';
import '../../utils/app_text_style.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final bool isOutlineButton;
  final VoidCallback? onPressed;
  final double radius;
  final bool isDisabled;
  final TextStyle? textStyle; // TextStyle tùy chỉnh
  final IconData? icon; // IconData tùy chỉnh

  const CustomButton({
    super.key,
    required this.text,
    this.textColor = kWhiteColor,
    this.backgroundColor = kPrimaryColor,
    this.isOutlineButton = false,
    this.onPressed,
    this.radius = kBorderRadiusXl,
    this.isDisabled = false,
    this.textStyle, // Khởi tạo textStyle tùy chỉnh
    this.icon, // Khởi tạo icon tùy chỉnh
  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    if (!widget.isDisabled) {
      setState(() {
        _isPressed = true;
      });
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (!widget.isDisabled) {
      setState(() {
        _isPressed = false;
      });
    }
  }

  void _onTapCancel() {
    if (!widget.isDisabled) {
      setState(() {
        _isPressed = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonColor = widget.isDisabled
        ? (widget.backgroundColor ?? kPrimaryColor).withOpacity(0.5)
        : (widget.backgroundColor ?? kPrimaryColor);

    // Xử lý hiệu ứng thụt vào khi nhấn
    final scale = _isPressed ? 0.95 : 1.0;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.isDisabled ? null : widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(kPaddingMd),
        decoration: BoxDecoration(
          color: widget.isOutlineButton
              ? Colors.transparent
              : buttonColor,
          border: widget.isOutlineButton
              ? Border.all(color: buttonColor)
              : null,
          borderRadius: BorderRadius.circular(widget.radius),
        ),
        // Áp dụng hiệu ứng scale cho toàn bộ container (bao gồm cả nền button)
        child: Transform.scale(
          scale: scale, // Áp dụng hiệu ứng thụt vào cho toàn bộ button
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Nếu có icon, hiển thị icon từ IconData
                if (widget.icon != null)
                  Icon(widget.icon!, color: widget.isDisabled ? Colors.grey : kWhiteColor, size: 16,),
                // Khoảng cách giữa icon và text
                if (widget.icon != null) const SizedBox(width: kMarginMd),
                // Hiển thị văn bản với TextStyle tùy chỉnh hoặc mặc định
                Text(
                  widget.text,
                  style: widget.textStyle ?? AppTextStyle.semibold(
                    kTextSizeLg,
                    widget.isOutlineButton ? buttonColor : widget.textColor!,
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
