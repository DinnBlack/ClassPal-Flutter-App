import 'package:flutter/material.dart';
import 'package:flutter_class_pal/core/constants/constant.dart';
import 'package:flutter_class_pal/core/constants/constant.dart';
import 'package:flutter_class_pal/core/constants/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomButtonCamera extends StatelessWidget {
  final Function()? onPressed;

  CustomButtonCamera({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashColor: kPrimaryColor.withAlpha(30),
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: kPrimaryColor,
            width: 2,
          ),
        ),
        child: const Icon(
          FontAwesomeIcons.camera,
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
