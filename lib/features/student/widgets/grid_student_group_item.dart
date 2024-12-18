import 'package:flutter/material.dart';
import '../../../core/constants/constant.dart';
import '../../../core/utils/app_text_style.dart';
import '../model/student_group_model.dart';

class GridStudentGroupItem extends StatefulWidget {
  final StudentGroupModel? group;
  final bool add;
  final VoidCallback? onTapCallback;

  const GridStudentGroupItem({
    Key? key,
    this.group,
    this.add = false,
    this.onTapCallback,
  }) : super(key: key);

  @override
  State<GridStudentGroupItem> createState() => _GridStudentGroupItemState();
}

class _GridStudentGroupItemState extends State<GridStudentGroupItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.95,
      upperBound: 1.0,
      duration: const Duration(milliseconds: 200),
    )..value = 1.0;
    _scaleAnimation = _controller;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> studentIds = widget.group?.students ?? [];
    int studentCount = studentIds.length;

    List<Widget> studentAvatars = [];
    double offset = 0.0;

    // Căn chỉnh avatar
    for (int i = 0; i < studentCount && i < 3; i++) {
      if (studentCount == 1) {
        offset = 0.0;
      } else if (studentCount == 2) {
        offset = (i == 0) ? -15.0 : 15.0;
      } else if (studentCount >= 3) {
        offset = (i == 0)
            ? -30.0
            : (i == 1)
            ? 0.0
            : 30.0;
      }

      studentAvatars.add(
        Align(
          alignment: Alignment.center,
          child: Transform.translate(
            offset: Offset(offset, 0),
            child: CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage('assets/images/boy.jpg'),
              backgroundColor: kPrimaryColor,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: kPrimaryColor, width: 1),
                ),
              ),
            ),
          ),
        ),
      );
    }

    if (studentCount > 3) {
      studentAvatars.add(
        Align(
          alignment: Alignment.center,
          child: Transform.translate(
            offset: const Offset(30.0, 0),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: kPrimaryColor,
              child: Text(
                '+${studentCount - 2}',
                style: AppTextStyle.semibold(kTextSizeXs, Colors.white),
              ),
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTapDown: (_) {
        _controller.animateTo(0.95, curve: Curves.easeOut);
      },
      onTapUp: (_) {
        _controller.animateTo(1.0, curve: Curves.easeOut);
        widget.onTapCallback?.call();
      },
      onTapCancel: () {
        _controller.animateTo(1.0, curve: Curves.easeOut);
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kBorderRadiusMd),
            border: Border.all(color: kGreyColor, width: 1),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.add)
                  Container(
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
                else
                  Container(
                    height: 48,
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.center,
                      children: studentAvatars,
                    ),
                  ),
                const SizedBox(height: kMarginSm),
                Text(
                  widget.add ? "Thêm mới" : widget.group?.name ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.semibold(
                    kTextSizeXs,
                    widget.add ? kPrimaryColor : kBlackColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
