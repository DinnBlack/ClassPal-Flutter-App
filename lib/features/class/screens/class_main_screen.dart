import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_class_pal/features/class/model/class_model.dart';
import 'package:flutter_class_pal/features/class/screens/class_page/class_dashboard_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/constants/constant.dart';
import '../../../core/utils/app_text_style.dart';
import 'class_page/class_schedule_page.dart';
import 'class_page/message_page_screen.dart';
import 'class_page/class_board_page.dart';

class ClassMainScreen extends StatefulWidget {
  static const route = 'ClassMainScreen';
  final ClassModel currentClass;

  const ClassMainScreen({super.key, required this.currentClass});

  @override
  _ClassMainScreenState createState() => _ClassMainScreenState();
}

class _ClassMainScreenState extends State<ClassMainScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final ScrollController _scrollController = ScrollController();

  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();

    _pages = [
      ClassDashboardPage(classData: widget.currentClass),
      ClassBoardPage(classData: widget.currentClass),
      ClassSchedulePage(classData: widget.currentClass),
      ClassMessagePage(classData: widget.currentClass),
    ];
  }

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
