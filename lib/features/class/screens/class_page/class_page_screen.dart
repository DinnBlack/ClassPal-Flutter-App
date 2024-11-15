import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_class_pal/features/class/screens/class_page/student_page_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/widgets/common_widget/custom_app_bar.dart';
import 'calendar_page_screen.dart';
import 'message_page_screen.dart';
import 'news_page_screen.dart';

class ClassPageScreen extends StatefulWidget {
  static const route = 'ClassPageScreen';

  const ClassPageScreen({super.key});

  @override
  _ClassPageScreenState createState() => _ClassPageScreenState();
}

class _ClassPageScreenState extends State<ClassPageScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final ScrollController _scrollController = ScrollController();

  void _onTabTapped(int index) {
    if (index == 2) {
      _showFavoriteBottomSheet();
      return;
    }

    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  final List<Widget> _pages = [
    StudentPageScreen(),
    NewsPageScreen(),
    CalendarPageScreen(),
    MessagePageScreen(),
  ];

  static const List<TabItem> items = [
    TabItem(
      icon: FontAwesomeIcons.school,
      title: 'Lớp Học',
    ),
    TabItem(
      icon: FontAwesomeIcons.newspaper,
      title: 'Bảng Tin',
    ),
    TabItem(
      icon: FontAwesomeIcons.star,
      title: '',
    ),
    TabItem(
      icon: FontAwesomeIcons.calendar,
      title: 'Lịch Học',
    ),
    TabItem(
      icon: FontAwesomeIcons.message,
      title: 'Tin Nhắn',
    ),
  ];

  void _showFavoriteBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "This is the wishlist BottomSheet!",
                style: AppTextStyle.bold(kTextSizeXl),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
            ],
          ),
        );
      },
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
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: BottomBarCreative(
        items: items,
        backgroundColor: kWhiteColor,
        color: kGreyColor,
        colorSelected: kPrimaryColor,
        indexSelected: _currentIndex,
        titleStyle: AppTextStyle.medium(10),
        onTap: _onTabTapped, 
      ),
    );
  }
}
