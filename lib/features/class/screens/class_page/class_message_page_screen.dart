import 'package:flutter/material.dart';
import 'package:flutter_class_pal/features/class/model/class_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/widgets/common_widget/custom_app_bar.dart';

class ClassMessagePage extends StatelessWidget {
  static const route = "ClassMessagePage";
  final ClassModel classData;

  const ClassMessagePage({super.key, required this.classData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      title: 'Tin nhắn',
      leading: const FaIcon(
        FontAwesomeIcons.arrowLeft,
        size: 20,
      ),
      titleStyle: AppTextStyle.bold(kTextSizeXl),
      isTitleCenter: true,
    );
  }
}
