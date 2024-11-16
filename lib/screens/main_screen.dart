import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';

import '../core/constants/constant.dart';
import '../core/utils/app_text_style.dart';
import '../core/widgets/common_widget/custom_app_bar.dart';
import '../core/widgets/common_widget/custom_list_item.dart';
import '../features/class/screens/class_main_screen.dart';

class MainScreen extends StatelessWidget {
  static const route = 'MainScreen';

  const MainScreen({super.key});

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
              backgroundColor: Colors.blue,
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
      body: const Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
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
            "Thầy Đinh Hoàng Phúc",
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
          CustomListItem(
            imageUrl: 'assets/images/school.png',
            title: 'THCS - THPT Long Bình',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Các lớp học của bạn",
                style: AppTextStyle.semibold(kTextSizeMd),
              ),
              GestureDetector(
                onTap: () {
                  showBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: EdgeInsets.all(16.0),
                        color: Colors.blue,
                        height: 200,
                        child: const Center(
                          child: Text(
                            'Nội dung của Bottom Sheet',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.add_rounded,
                      color: kPrimaryColor,
                      size: 18,
                    ),
                    Text("Thêm lớp học",
                        style:
                            AppTextStyle.semibold(kTextSizeSm, kPrimaryColor)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: kMarginMd,
          ),
          CustomListItem(
            imageUrl: 'assets/images/class.png',
            title: 'Lớp 9a2',
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
