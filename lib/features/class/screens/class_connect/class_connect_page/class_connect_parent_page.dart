import 'package:flutter/material.dart';
import 'package:flutter_class_pal/core/constants/constant.dart';
import 'package:flutter_class_pal/core/utils/app_text_style.dart';

class ClassConnectParentPage extends StatelessWidget {
  const ClassConnectParentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: kMarginLg,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              '0%',
              style: AppTextStyle.semibold(kTextSizeXxl, kPrimaryColor),
            ),
          ),
          const SizedBox(
            height: kMarginMd,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Phụ huynh học sinh đã được kết nối',
              style: AppTextStyle.semibold(kTextSizeXs),
            ),
          ),
          const SizedBox(
            height: kMarginXxl,
          ),
          Text(
            'Chưa kết nối (5)',
            style: AppTextStyle.semibold(kTextSizeMd, kGreyColor),
          ),
          const SizedBox(
            height: kMarginMd,
          ),
          Text(
            'Đã kết nối (10)',
            style: AppTextStyle.semibold(kTextSizeMd, kGreyColor),
          ),
        ],
      ),
    );
  }
}
