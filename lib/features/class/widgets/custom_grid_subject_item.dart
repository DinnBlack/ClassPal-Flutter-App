import 'package:flutter/material.dart';
import 'package:flutter_class_pal/core/constants/constant.dart';
import 'package:flutter_class_pal/core/utils/app_text_style.dart';
import 'package:flutter_class_pal/features/class/screens/class_score/class_score_subject_screen.dart';
import 'package:flutter_class_pal/features/class/screens/class_score/class_subject_create_screen.dart';

import '../model/subject_model.dart';

class CustomGridSubjectItem extends StatefulWidget {
  final bool isAddButton;
  final SubjectModel? subject;

  const CustomGridSubjectItem(
      {super.key, this.subject, this.isAddButton = false});

  @override
  State<CustomGridSubjectItem> createState() => _CustomGridSubjectItemState();
}

class _CustomGridSubjectItemState extends State<CustomGridSubjectItem>
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
    return GestureDetector(
      onTap: () {
        if (widget.isAddButton) {
          // Handle the "Thêm môn" button tap
          Navigator.pop(context);
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return const FractionallySizedBox(
                alignment: Alignment.bottomCenter,
                heightFactor: 0.95,
                child: ClassSubjectCreateScreen(),
              );
            },
          );
        } else {
          // Handle other subject item tap
          Navigator.pop(context);
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return FractionallySizedBox(
                alignment: Alignment.bottomCenter,
                heightFactor: 0.95,
                child: ClassScoreSubjectScreen(subject: widget.subject!),
              );
            },
          );
        }
      },
      onTapDown: (_) {
        _controller.animateTo(0.95, curve: Curves.easeOut);
      },
      onTapUp: (_) {
        _controller.animateTo(1.0, curve: Curves.easeOut);
      },
      onTapCancel: () {
        _controller.animateTo(1.0, curve: Curves.easeOut);
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingMd),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kBorderRadiusMd),
            border: Border.all(color: kGreyColor, width: 1),
          ),
          child: Row(
            children: widget.isAddButton
                ? [
                    Image.network(
                      'https://picsum.photos/200',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: kMarginMd,
                    ),
                    Expanded(
                      child: Text(
                        'Thêm môn',
                        textAlign: TextAlign.center,
                        style: AppTextStyle.semibold(kTextSizeSm, kPrimaryColor)
                      ),
                    ),
                  ]
                : [
                    Image.network(
                      widget.subject!.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: kMarginMd,
                    ),
                    Expanded(
                      child: Text(
                        widget.subject!.name,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.semibold(kTextSizeSm),
                      ),
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}
