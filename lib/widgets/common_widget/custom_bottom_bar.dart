import 'package:flutter/material.dart';

class CustomBottomBar extends StatefulWidget {
  final List<BottomBarItem> items; // Các tab item
  final bool showFloatingButton; // Quyết định hiển thị floating button
  final ValueChanged<int> onTabTapped; // Hàm gọi khi tab được chọn
  final int currentIndex; // Chỉ số của tab hiện tại

  const CustomBottomBar({
    super.key,
    required this.items,
    required this.onTabTapped,
    this.showFloatingButton = true,
    this.currentIndex = 0,
  });

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,  // Chiều cao của bottom bar
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Đặt các item cách đều nhau
        children: [
          // Tab item 1
          _buildTabItem(0),
          _buildSpacer(),  // Chỗ cho floating button
          if (widget.showFloatingButton)
            _buildFloatingButton(),
          // Tab item 2
          _buildTabItem(1),
          // Tab item 3
          _buildTabItem(2),
        ],
      ),
    );
  }

  Widget _buildTabItem(int index) {
    final item = widget.items[index];
    return GestureDetector(
      onTap: () => widget.onTabTapped(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            item.icon,
            color: widget.currentIndex == index ? Colors.blue : Colors.grey,
          ),
          Text(
            item.text,
            style: TextStyle(
              color: widget.currentIndex == index ? Colors.blue : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpacer() {
    return Expanded(
      child: SizedBox(),
    );
  }

  Widget _buildFloatingButton() {
    return GestureDetector(
      onTap: () {
        // Handle action khi nhấn vào floating button
        print("Floating button pressed");
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class BottomBarItem {
  final IconData icon;
  final String text;

  BottomBarItem({required this.icon, required this.text});
}
