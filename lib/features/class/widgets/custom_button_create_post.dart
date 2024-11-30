import 'package:flutter/material.dart';
import 'package:flutter_class_pal/core/constants/constant.dart';

import '../../../core/utils/app_text_style.dart';
import '../../../core/widgets/normal_widget/custom_avatar.dart';

class CustomButtonCreatePost extends StatelessWidget {
  final String? avatarImage;
  final String? avatarText;
  final VoidCallback? onPressed;

  const CustomButtonCreatePost({
    Key? key,
    this.avatarImage,
    this.avatarText,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(kPaddingMd),
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(kBorderRadiusXl),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar
            CustomAvatar(
              imageAsset: avatarImage,
              text: avatarText,
              size: 40,
            ),
            const SizedBox(width: kMarginMd),
            // Text
            Expanded(
              child: Text(
                'Bạn đang nghĩ gì?',
                style: AppTextStyle.regular(kTextSizeMd, kPrimaryColor),
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
