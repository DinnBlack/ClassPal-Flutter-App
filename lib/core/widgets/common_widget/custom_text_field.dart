import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart'; // Import the intl package
import '../../constants/constant.dart';
import '../../utils/app_text_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  final bool isDateTimePicker; // New parameter to handle date picker
  final Widget? suffixIcon; // New parameter for optional suffix icon

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
    this.isDateTimePicker = false, // Default is false
    this.suffixIcon, // Initialize with default null
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
                        style: AppTextStyle.medium(kTextSizeMd),
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      // Update _selectedOption when user selects an option
                      _selectedOption = widget.options![index];
                      // Update the controller text with the selected option
                      widget.controller?.text = _selectedOption;
                    });
                    if (widget.onChanged != null) {
                      // Call onChanged to pass the selected value
                      widget.onChanged!(_selectedOption);
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

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      // Format the picked date to dd/MM/yyyy
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      widget.controller?.text = formattedDate;

      if (widget.onChanged != null) {
        widget.onChanged!(formattedDate); // Pass the formatted date to onChanged
      }
    }
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
        keyboardType: widget.isNumber ? TextInputType.number : TextInputType.text,
        obscureText: widget.isPassword && _isObscured,
        readOnly: isOptionMode || widget.isDateTimePicker, // Make text field readonly if options or date picker
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
          suffixIcon: widget.suffixIcon ?? (isOptionMode
              ? const Icon(
            Icons.arrow_drop_down_circle_outlined,
            color: kGreyColor,
            size: 16,
          )
              : (widget.isPassword
              ? InkWell(
            child: Icon(
              _isObscured ? Icons.visibility : Icons.visibility_off,
              size: 16,
            ),
            onTap: () {
              setState(() {
                _isObscured = !_isObscured;
              });
            },
          )
              : null)),
        ),
        onTap: widget.isDateTimePicker ? _selectDate : (isOptionMode ? _showOptionsDialog : null),
        inputFormatters: widget.isNumber ? [FilteringTextInputFormatter.digitsOnly] : null,
      ),
    );
  }
}
