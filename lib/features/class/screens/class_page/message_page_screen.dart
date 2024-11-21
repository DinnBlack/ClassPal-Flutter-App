import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/widgets/common_widget/custom_app_bar.dart';
import '../../model/class_model.dart';

class ClassMessagePage extends StatelessWidget {
  static const route = 'ClassMessagePage';
  final ClassModel classData;

  const ClassMessagePage({super.key, required this.classData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Tin Nhắn',
        leading: const FaIcon(
          FontAwesomeIcons.arrowLeft,
          size: 20,
        ),
        titleStyle: AppTextStyle.bold(kTextSizeXl),
        actions: [
          const FaIcon(
            FontAwesomeIcons.bell,
            size: 20,
          ),
          InkWell(
            child: const FaIcon(
              FontAwesomeIcons.ellipsis,
              size: 20,
            ),
            onTap: () {},
          ),
        ],
        isTitleCenter: true,
      ),
    );
  }
}
