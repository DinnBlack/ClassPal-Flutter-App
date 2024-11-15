import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/widgets/common_widget/custom_tab_bar.dart';
import '../../../student/screens/student_list/student_list_screen.dart';

class StudentPageScreen extends StatefulWidget {
  static const route = "StudentPageScreen";

  const StudentPageScreen({super.key});

  @override
  State<StudentPageScreen> createState() => _StudentPageScreenState();
}

class _StudentPageScreenState extends State<StudentPageScreen> {
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
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          Stack(
            children: [
              Center(
                child: CustomTabBar(
                  currentIndex: _currentIndex,
                  onTabTapped: _onTabTapped,
                  tabTitles: const ["HỌC SINH", "NHÓM"],
                  tabBarWidthRatio: 2 / 3,
                  lineHeight: 4,
                  linePadding: 10.0,
                  tabBarHeight: 40,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: kPaddingMd),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kBorderRadiusMd),
                      border: Border.all(
                        color: kGreyColor,
                        width: 1,
                      ),
                    ),
                    child: const Center(
                      child: FaIcon(
                        FontAwesomeIcons.childReaching,
                        size: 16,
                        color: kGreyColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: [
                StudentListScreen(),
                const Center(
                  child: Text(
                    'NHÓM',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
