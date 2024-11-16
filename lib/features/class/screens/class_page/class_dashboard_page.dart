import 'package:flutter/material.dart';
import 'package:flutter_class_pal/core/widgets/common_widget/custom_list_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/widgets/common_widget/custom_app_bar.dart';
import '../../../../core/widgets/common_widget/custom_tab_bar.dart';
import '../../../student/screens/student_group/student_group_screen.dart';
import '../../../student/screens/student_list/student_list_screen.dart';

class ClassDashboardPage extends StatefulWidget {
  static const route = "ClassDashboardPage";

  const ClassDashboardPage({super.key});

  @override
  State<ClassDashboardPage> createState() => _ClassDashboardPageState();
}

class _ClassDashboardPageState extends State<ClassDashboardPage> {
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

  void _showOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(kBorderRadiusMd),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(kPaddingMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomListItem(
                title: 'Kết nối phụ huynh',
                titleStyle: AppTextStyle.medium(kTextSizeSm),
                onTap: () {},
                customLeadingWidget: const FaIcon(
                  FontAwesomeIcons.paperclip,
                  size: 18,
                ),
              ),
              const SizedBox(
                height: kMarginSm,
              ),
              CustomListItem(
                title: 'Thêm giáo viên',
                titleStyle: AppTextStyle.medium(kTextSizeSm),
                onTap: () {},
                customLeadingWidget: const FaIcon(
                  FontAwesomeIcons.userPlus,
                  size: 18,
                ),
              ),
              const SizedBox(
                height: kMarginSm,
              ),
              CustomListItem(
                title: 'Thiết lập lại điểm',
                titleStyle: AppTextStyle.medium(kTextSizeSm),
                onTap: () {},
                customLeadingWidget: const FaIcon(
                  FontAwesomeIcons.repeat,
                  size: 18,
                ),
              ),
              const SizedBox(
                height: kMarginSm,
              ),
              CustomListItem(
                title: 'Sắp xếp danh sách lớp',
                titleStyle: AppTextStyle.medium(kTextSizeSm),
                onTap: () {},
                customLeadingWidget: const FaIcon(
                  FontAwesomeIcons.arrowDownAZ,
                  size: 18,
                ),
              ),
              const SizedBox(
                height: kMarginSm,
              ),
              CustomListItem(
                title: 'Chỉnh cấu hình điểm',
                titleStyle: AppTextStyle.medium(kTextSizeSm),
                onTap: () {},
                customLeadingWidget: const FaIcon(
                  FontAwesomeIcons.fiveHundredPx,
                  size: 18,
                ),
              ),
              const SizedBox(
                height: kMarginSm,
              ),
              CustomListItem(
                title: 'Sửa thông tin lớp',
                titleStyle: AppTextStyle.medium(kTextSizeSm),
                onTap: () {},
                customLeadingWidget: const FaIcon(
                  FontAwesomeIcons.penToSquare,
                  size: 18,
                ),
              ),
              const SizedBox(
                height: kMarginSm,
              ),
              CustomListItem(
                title: 'Xóa lớp',
                titleStyle: AppTextStyle.medium(kTextSizeSm),
                onTap: () {},
                customLeadingWidget: const FaIcon(
                  FontAwesomeIcons.trashCan,
                  size: 18,
                ),
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
      backgroundColor: kBackgroundColor,
      appBar: CustomAppBar(
        title: 'Lớp 9a3',
        leading: const FaIcon(
          FontAwesomeIcons.arrowLeft,
          size: 20,
        ),
        titleStyle: AppTextStyle.bold(kTextSizeXl),
        actions: [
          const FaIcon(
            FontAwesomeIcons.bell,
            size: 20,
          ),
          InkWell(
            child: const FaIcon(
              FontAwesomeIcons.ellipsis,
              size: 20,
            ),
            onTap: () {
              // Gọi hàm để hiển thị BottomSheet
              _showOptionsBottomSheet(context);
            },
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
                    width: 35,
                    height: 35,
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
                const StudentGroupScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
