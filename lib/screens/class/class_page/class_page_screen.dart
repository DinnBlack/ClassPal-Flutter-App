import 'package:flutter/material.dart';
import 'package:flutter_class_pal/widgets/common_widget/custom_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/constants/constant.dart';
import '../../../utils/ui_util/app_text_style.dart';
import '../../../widgets/common_widget/custom_app_bar.dart';
import '../../../widgets/common_widget/custom_tab_bar.dart';

class ClassPageScreen extends StatefulWidget {
  static const route = 'ClassPageScreen';

  const ClassPageScreen({super.key});

  @override
  _ClassPageScreenState createState() => _ClassPageScreenState();
}

class _ClassPageScreenState extends State<ClassPageScreen> {
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
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Lớp 9a3',
        leading: const FaIcon(
          FontAwesomeIcons.arrowLeft,
          size: 20,
        ),
        titleStyle: AppTextStyle.bold(
          kTextSizeXl,
        ),
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
              children: const [
                Center(
                  child: Text(
                    'HỌC SINH',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Center(
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
      bottomNavigationBar: CustomBottomBar(
        items: [
          BottomBarItem(icon: Icons.home, text: "Home"),
          BottomBarItem(icon: Icons.search, text: "Search"),
          BottomBarItem(icon: Icons.notifications, text: "Notifications"),
          BottomBarItem(icon: Icons.settings, text: "Settings"),
        ],
        currentIndex: _currentIndex, // Chỉ số tab hiện tại
        onTabTapped: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        showFloatingButton:
            true, // Hiển thị hoặc không hiển thị floating button
      ),
    );
  }
}
