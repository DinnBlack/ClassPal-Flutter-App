import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/constant.dart';
import '../../../core/utils/app_text_style.dart';
import '../model/student_model.dart';

class GridStudentItem extends StatefulWidget {
  final StudentModel? student;  // Để student có thể nhận null
  final bool add;
  final VoidCallback? onTapCallback;  // Thêm callback cho sự kiện nhấn

  const GridStudentItem({
    super.key,
    this.student,  // student có thể là null khi add = true
    this.add = false,
    this.onTapCallback,  // Truyền callback
  });

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
    return GestureDetector(
      onTapDown: (_) => _controller.reverse(),
      onTapUp: (_) => _controller.forward(),
      onTapCancel: () => _controller.forward(),
      onTap: () {
        print("Grid item tapped!");
        if (widget.onTapCallback != null) {
          widget.onTapCallback!();
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
              if (!widget.add)
                Positioned(
                  top: 6,
                  right: 6,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      'A',
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
