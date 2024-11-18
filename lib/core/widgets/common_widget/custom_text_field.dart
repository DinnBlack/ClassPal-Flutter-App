import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/constant.dart';
import '../../utils/app_text_style.dart';

class CustomTextField extends StatefulWidget {
  final String? text; // Có thể null
  final bool isPassword;
  final bool isNumber;
  final List<String>? options;
  final double height;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final bool autofocus;
  final String? defaultValue;

  const CustomTextField({
    super.key,
    this.text,
    this.isPassword = false,
    this.isNumber = false,
    this.options,
    this.height = 60.0,
    this.controller,
    this.onChanged,
    this.autofocus = false,
    this.defaultValue,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = true;
  late FocusNode _focusNode;
  String _selectedOption = "";

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });

    if (widget.autofocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(_focusNode);
      });
    }

    if (widget.defaultValue != null) {
      _selectedOption = widget.defaultValue!;
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _showOptionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: double.minPositive,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kBorderRadiusXl),
              color: kWhiteColor,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.options?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Container(
                    width: double.infinity,
                    color: kTransparentColor,
                    padding: const EdgeInsets.all(kPaddingLg),
                    child: Center(
                      child: Text(
                        widget.options![index],
                        style: AppTextStyle.medium(
                          kTextSizeMd,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _selectedOption = widget.options![index];
                    });
                    if (widget.onChanged != null) {
                      widget.onChanged!(widget.options![index]);
                    }
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isOptionMode = widget.options != null;

    return SizedBox(
      height: widget.height,
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        autofocus: widget.autofocus,
        keyboardType:
        widget.isNumber ? TextInputType.number : TextInputType.text,
        obscureText: widget.isPassword && _isObscured,
        readOnly: isOptionMode,
        decoration: InputDecoration(
          labelText: widget.text?.isNotEmpty == true ? widget.text : null,
          labelStyle: AppTextStyle.light(kTextSizeMd, kGreyColor),
          contentPadding: EdgeInsets.zero,
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: _focusNode.hasFocus ? kPrimaryColor : kLightGreyColor,
              width: 1.0,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: _focusNode.hasFocus ? kPrimaryColor : kLightGreyColor,
              width: 1.0,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: kPrimaryColor,
              width: 1.0,
            ),
          ),
          suffixIcon: isOptionMode
              ? const Icon(
            Icons.arrow_drop_down_circle_outlined,
            color: kGreyColor,
            size: 16,
          )
              : (widget.isPassword
              ? InkWell(
            child: Icon(
              _isObscured
                  ? Icons.visibility
                  : Icons.visibility_off,
              size: 16,
            ),
            onTap: () {
              setState(() {
                _isObscured = !_isObscured;
              });
            },
          )
              : null),
        ),
        onTap: isOptionMode ? _showOptionsDialog : null,
        inputFormatters:
        widget.isNumber ? [FilteringTextInputFormatter.digitsOnly] : null,
      ),
    );
  }
}
