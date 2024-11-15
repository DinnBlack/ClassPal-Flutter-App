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

  const CustomButton({
    super.key,
    required this.text,
    this.textColor = kWhiteColor,
    this.backgroundColor = kPrimaryColor,
    this.isOutlineButton = false,
    this.onPressed,
    this.radius = kBorderRadiusXl,
    this.isDisabled = false,
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
          boxShadow: _isPressed && !widget.isDisabled
              ? [
            BoxShadow(
              color: buttonColor.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 8,
            ),
          ]
              : [],
        ),
        child: Center(
          child: Text(
            widget.text,
            style: AppTextStyle.semibold(
              kTextSizeLg,
              widget.isOutlineButton ? buttonColor : widget.textColor!,
            ),
          ),
        ),
      ),
    );
  }
}
