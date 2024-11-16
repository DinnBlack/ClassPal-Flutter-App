import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/widgets/common_widget/custom_app_bar.dart';

class ClassBoardPage extends StatelessWidget {
  static const route = 'ClassBoardPage';
  const ClassBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Lớp 9a3',
        leading: const FaIcon(
          FontAwesomeIcons.arrowLeft,
          size: 20,
        ),
        titleStyle: AppTextStyle.bold(kTextSizeXl),
        actions: const [
          FaIcon(
            FontAwesomeIcons.bell,
            size: 20,
          ),
          FaIcon(
            FontAwesomeIcons.ellipsis,
            size: 20,
          ),
        ],
        isTitleCenter: true,
      ),
    );
  }
}
