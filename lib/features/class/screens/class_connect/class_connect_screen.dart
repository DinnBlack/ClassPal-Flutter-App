import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/widgets/common_widget/custom_tab_bar.dart';
import 'class_connect_page/class_connect_parent_page.dart';
import 'class_connect_page/class_connect_student_page.dart';
import 'class_connect_page/class_connect_teacher_page.dart';

class ClassConnectScreen extends StatefulWidget {
  const ClassConnectScreen({super.key});

  @override
  State<ClassConnectScreen> createState() => _ClassConnectScreenState();
}

class _ClassConnectScreenState extends State<ClassConnectScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(kBorderRadiusMd)),
      ),
      child: Column(
        children: [
          const SizedBox(height: kMarginMd),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPaddingMd),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    child: const FaIcon(FontAwesomeIcons.xmark),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Center(
                  child: Text(
                    'Kết nối lớp học',
                    style: AppTextStyle.bold(kTextSizeLg),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: kMarginLg),
          Center(
            child: CustomTabBar(
              currentIndex: _currentIndex,
              onTabTapped: _onTabTapped,
              tabTitles: const ["PHỤ HUYNH", "GIÁO VIÊN", "HỌC SINH"],
              tabBarWidthRatio: 0.9,
              lineHeight: 4,
              linePadding: 10.0,
              tabBarHeight: 40,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPaddingMd),
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: const [
                  ClassConnectParentPage(),
                  ClassConnectTeacherPage(),
                  ClassConnectStudentPage(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
