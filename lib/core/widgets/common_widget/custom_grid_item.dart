import 'package:flutter/material.dart';

import '../../constants/constant.dart';
import '../../utils/app_text_style.dart';

class CustomGridItem extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String value;

  const CustomGridItem({
    Key? key,
    required this.avatarUrl,
    required this.name,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(avatarUrl),
                onBackgroundImageError: (error, stackTrace) {
                  print("Error loading image: $error");
                },
              ),
              const SizedBox(height: kMarginSm),
              Container(
                height: 30,
                alignment: Alignment.center,
                child: Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.semibold(10),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 6,
          right: 6,
          child: CircleAvatar(
            radius: 10,
            backgroundColor: Colors.red,
            child: Text(
              value,
              style: AppTextStyle.semibold(10, kWhiteColor),
            ),
          ),
        ),
      ],
    );
  }
}
