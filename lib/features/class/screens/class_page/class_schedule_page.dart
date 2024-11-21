import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/widgets/common_widget/custom_app_bar.dart';
import '../../model/class_model.dart';

class ClassSchedulePage extends StatelessWidget {
  static const route = "ClassSchedulePage";
  final ClassModel classData;

  const ClassSchedulePage({super.key, required this.classData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Lịch học',
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
