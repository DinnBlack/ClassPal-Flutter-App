import 'package:flutter/material.dart';
import 'package:flutter_class_pal/utils/constants/constant.dart';
import '../../utils/ui_util/app_text_style.dart';
import '../../widgets/common_widget/select_role_item.dart';

class SelectRoleScreen extends StatelessWidget {
  static const route = 'SelectRoleScreen';

  const SelectRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(kPaddingXl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lựa chọn tài khoản của bạn',
              style: AppTextStyle.semibold(kTextSizeLg, kGreyColor),
            ),
            Text(
              'Bạn là?',
              style: AppTextStyle.bold(kTextSizeXxl),
            ),
            const SizedBox(
              height: kMarginXl,
            ),
            const SelectRoleItem(
              title: 'Giáo viên',
              subtitle: 'Tạo và quản lý lớp học\ncủa bạn',
              imageAsset: 'assets/images/teacher.jpg',
            ),
            const SizedBox(
              height: kMarginXl,
            ),
            const SelectRoleItem(
              title: 'Phụ huynh',
              subtitle: 'Giữ kết nối với con của bạn trên lớp',
              imageAsset: 'assets/images/parent.jpg',
            ),
          ],
        ),
      ),
    );
  }
}
