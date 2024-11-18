import 'package:flutter/material.dart';
import 'package:flutter_class_pal/core/state/app_state.dart';
import 'package:flutter_class_pal/core/widgets/common_widget/custom_button.dart';
import 'package:flutter_class_pal/features/user/model/user_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';

import '../core/constants/constant.dart';
import '../core/utils/app_text_style.dart';
import '../core/widgets/common_widget/custom_app_bar.dart';
import '../core/widgets/common_widget/custom_list_item.dart';
import '../features/class/screens/class_main_screen.dart';

class MainScreen extends StatefulWidget {
  static const route = 'MainScreen';

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final UserModel? currentUser = AppState.getUser();

  void showTopSheet(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.topCenter,
          child: Material(
            color: Colors.transparent,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(kBorderRadiusMd),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(kPaddingMd),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: CustomAppBar(
        leading: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: kPrimaryColor,
              child: FaIcon(
                FontAwesomeIcons.solidUser,
                size: 18,
              ),
            ),
            SizedBox(width: kMarginSm),
            FaIcon(
              FontAwesomeIcons.chevronDown,
              size: 14,
            ),
          ],
        ),
        onLeadingTap: () {
          print("Menu tapped");
        },
      ),
      body: Body(currentUser: currentUser),
    );
  }
}

class Body extends StatelessWidget {
  final UserModel? currentUser;

  const Body({
    super.key,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kPaddingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Xin chào",
            style: AppTextStyle.semibold(kTextSizeMd, kGreyColor),
          ),
          Text(
            "${currentUser?.gender} ${currentUser?.name}",
            style: AppTextStyle.semibold(kTextSizeXl),
          ),
          const SizedBox(
            height: kMarginXl,
          ),
          Text(
            "Trường học",
            style: AppTextStyle.semibold(kTextSizeMd),
          ),
          const SizedBox(
            height: kMarginMd,
          ),
          // Kiểm tra xem người dùng đã có trường học hay chưa
          if (currentUser?.schoolsIds == null ||
              currentUser?.schoolsIds?.isEmpty == true)
            CustomButton(
              text: 'Thêm trường học',
              textStyle: AppTextStyle.medium(kTextSizeMd, kWhiteColor),
              icon: FontAwesomeIcons.plus,
            ),
          // Nếu người dùng đã có trường học, hiển thị thông tin trường học
          if (currentUser?.schoolsIds != null &&
              currentUser?.schoolsIds?.isNotEmpty == true)
            CustomListItem(
              imageUrl: 'assets/images/school.png',
              title: currentUser?.schoolsIds[0] ?? 'Trường học không có',
              subtitle: 'Flutter Developer',
              textColor: Colors.black,
              onTap: () {
                print('Item tapped!');
              },
              leadingIcon: Iconsax.information5,
              trailingIcon: true,
            ),
          const SizedBox(
            height: kMarginMd,
          ),
          Text(
            "Các lớp học của bạn",
            style: AppTextStyle.semibold(kTextSizeMd),
          ),
          const SizedBox(
            height: kMarginMd,
          ),
          // Kiểm tra xem người dùng đã có lớp học hay chưa
          if (currentUser?.classesIds == null ||
              currentUser?.classesIds?.isEmpty == true)
            CustomButton(
              text: 'Thêm lớp học',
              textStyle: AppTextStyle.medium(kTextSizeMd, kWhiteColor),
              icon: FontAwesomeIcons.plus,
            ),
          // Nếu người dùng đã có lớp học, hiển thị thông tin lớp học
          if (currentUser?.classesIds != null &&
              currentUser?.classesIds?.isNotEmpty == true)
            CustomListItem(
              imageUrl: 'assets/images/class.png',
              title: 'Lớp 9a2',
              // Cập nhật lại theo thông tin lớp học từ currentUser
              textColor: Colors.black,
              onTap: () {
                Navigator.pushNamed(context, ClassMainScreen.route);
              },
              trailingIcon: true,
            ),
          const SizedBox(
            height: kMarginMd,
          ),
          Text(
            "Lớp học cá nhân",
            style: AppTextStyle.semibold(kTextSizeMd),
          ),
        ],
      ),
    );
  }
}
