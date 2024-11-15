import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/constant.dart';
import '../../utils/app_text_style.dart';

class BottomBarItem {
  final Widget? icon;
  final String text;

  BottomBarItem({this.icon, required this.text});
}

class CustomBottomBar extends StatelessWidget {
  final List<BottomBarItem> items;
  final int currentIndex;
  final Function(int) onTabTapped;
  final bool showFloatingButton;

  const CustomBottomBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTabTapped,
    this.showFloatingButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: kLightGreyColor, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(items.length, (index) {
                final item = items[index];
                final isSelected = index == currentIndex;

                return GestureDetector(
                  onTap: () => onTabTapped(index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (item.icon != null)
                        (item.icon is FaIcon)
                            ? FaIcon(
                                (item.icon as FaIcon).icon,
                                color: isSelected ? kPrimaryColor : kGreyColor,
                                size: (item.icon as FaIcon).size,
                              )
                            : (item.icon is Icon)
                                ? Icon(
                                    (item.icon as Icon).icon,
                                    color:
                                        isSelected ? kPrimaryColor : kGreyColor,
                                    size: (item.icon as Icon).size,
                                  )
                                : item.icon!
                      else
                        const SizedBox.shrink(),
                      const SizedBox(height: 4),
                      Text(
                        item.text,
                        style: AppTextStyle.semibold(
                          10,
                          isSelected ? kPrimaryColor : kGreyColor,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
        if (showFloatingButton)
          Positioned(
            bottom: 35,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: kPrimaryColor,
              child: const Icon(Icons.add),
            ),
          ),
      ],
    );
  }
}
