import 'package:flutter/material.dart';

import '../../../core/constants/constant.dart';
import '../../../core/utils/app_text_style.dart';

class GridStudentItem extends StatefulWidget {
  final String? avatarUrl;
  final String name;
  final String value;
  final bool add;

  const GridStudentItem({
    Key? key,
    this.avatarUrl,
    required this.name,
    required this.value,
    this.add = false,
  }) : super(key: key);

  @override
  State<GridStudentItem> createState() => _GridStudentItemState();
}

class _GridStudentItemState extends State<GridStudentItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.95,
      upperBound: 1.0,
      duration: const Duration(milliseconds: 200), // Add a duration for the animation
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.reverse(),
      onTapUp: (_) => _controller.forward(),
      onTapCancel: () => _controller.forward(),
      onTap: () {
        print("Grid item tapped!");
      },
      child: ScaleTransition(
        scale: _controller,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kBorderRadiusMd),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    widget.add
                        ? Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: kGreyColor,
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: kPrimaryColor,
                      ),
                    )
                        : CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage(widget.avatarUrl ?? ''),
                      onBackgroundImageError: (error, stackTrace) {
                        print("Error loading image: $error");
                      },
                    ),
                    const SizedBox(height: kMarginSm),
                    Container(
                      height: 30,
                      alignment: Alignment.center,
                      child: Text(
                        widget.add ? "Thêm mới" : widget.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.semibold(
                          10,
                          widget.add ? kPrimaryColor : kBlackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (!widget.add)
                Positioned(
                  top: 6,
                  right: 6,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      widget.value,
                      style: AppTextStyle.semibold(10, kWhiteColor),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
