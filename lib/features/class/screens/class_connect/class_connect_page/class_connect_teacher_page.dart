import 'package:flutter/material.dart';
import 'package:flutter_class_pal/core/widgets/common_widget/custom_button.dart';

import '../../../../../core/constants/constant.dart';
import '../../../../../core/utils/app_text_style.dart';
import '../../../../../core/widgets/normal_widget/invite_user.dart';

class ClassConnectTeacherPage extends StatelessWidget {
  const ClassConnectTeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: kMarginLg,
          ),
          Text(
            'Thêm giáo viên vào lớp học',
            style: AppTextStyle.semibold(kTextSizeXs),
          ),
          const SizedBox(
            height: kMarginMd,
          ),
           Padding(
            padding: EdgeInsets.symmetric(horizontal: kPaddingXl),
            child: CustomButton(
              text: 'Thêm giáo viên',
              onPressed: () {
                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: '',
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return Center(
                      child: ScaleTransition(
                        scale: CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOut,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InviteUser(),
                        ),
                      ),
                    );
                  },
                  transitionBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 300),
                );
              },
            ),
          ),
          const SizedBox(
            height: kMarginLg,
          ),
        ],
      ),
    );
  }
}
