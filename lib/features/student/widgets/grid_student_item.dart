import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/constant.dart';
import '../../../core/utils/app_text_style.dart';
import '../model/student_model.dart';

class GridStudentItem extends StatefulWidget {
  final StudentModel? student;
  final bool add;
  final VoidCallback? onTapCallback;
  final bool isSelected;
  final ValueChanged<bool> onSelectionChanged;
  final bool isFetchWithoutGroup;  // Add this property to handle the fetch condition

  const GridStudentItem({
    super.key,
    this.student,
    this.add = false,
    this.onTapCallback,
    this.isSelected = false,
    required this.onSelectionChanged,
    this.isFetchWithoutGroup = false,  // Default value is false
  });

  @override
  State<GridStudentItem> createState() => _GridStudentItemState();
}

class _GridStudentItemState extends State<GridStudentItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.95,  // Scale when selected
      upperBound: 1.0,   // Scale when not selected
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Update the controller's scale when the selection changes
    if (widget.isSelected) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    return GestureDetector(
      onTapDown: (_) => widget.isFetchWithoutGroup ? _controller.reverse() : null,
      onTapUp: (_) => widget.isFetchWithoutGroup ? _controller.forward() : null,
      onTapCancel: () => widget.isFetchWithoutGroup ? _controller.forward() : null,
      onTap: () {
        if (widget.isFetchWithoutGroup) {
          widget.onSelectionChanged(!widget.isSelected); // Toggle the selection state
        } else {
          // If not in `isFetchWithoutGroup`, simply trigger the callback without selection logic
          if (widget.onTapCallback != null) {
            widget.onTapCallback!();
          }
        }
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
                      width: 60,
                      height: 60,
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
                      backgroundImage: AssetImage(
                        widget.student?.gender == 'Nam'
                            ? 'assets/images/boy.jpg'
                            : 'assets/images/girl.jpg',
                      ),
                      radius: 30,
                    ),
                    const SizedBox(height: kMarginSm),
                    Container(
                      height: 30,
                      alignment: Alignment.center,
                      child: Text(
                        widget.add ? "Thêm mới" : widget.student?.name ?? '',
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
              // Only show checkmark if the item is selected and `isFetchWithoutGroup` is true
              if (!widget.add && widget.isSelected && widget.isFetchWithoutGroup)
                Positioned(
                  top: 6,
                  right: 6,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.green,
                    child: const Icon(
                      Icons.check,
                      color: kWhiteColor,
                      size: 14,
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
