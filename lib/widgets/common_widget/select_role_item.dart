import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_class_pal/utils/constants/constant.dart';
import '../../features/auth/bloc/auth_bloc.dart';
import '../../screens/auth/register_screen.dart';
import '../../utils/ui_util/app_text_style.dart';

class SelectRoleItem extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String imageAsset;

  const SelectRoleItem({
    super.key,
    required this.title,
    this.subtitle,
    required this.imageAsset,
  });

  @override
  _SelectRoleItemState createState() => _SelectRoleItemState();
}

class _SelectRoleItemState extends State<SelectRoleItem> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? kBlackColor : kWhiteColor;
    final textColor = isDarkMode ? kWhiteColor : kBlackColor;

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _scale = 0.95;
        });
      },
      onTapUp: (_) {
        setState(() {
          _scale = 1.0;
        });
      },
      onTapCancel: () {
        setState(() {
          _scale = 1.0;
        });
      },
      onTap: () {
        context.read<AuthBloc>().add(RoleSelected(widget.title));
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return const FractionallySizedBox(
                alignment: Alignment.bottomCenter,
                heightFactor: 0.95,
                child: RegisterScreen());
          },
        );
      },
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 200),
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: kPaddingLg, vertical: kPaddingLg),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(kBorderRadiusLg),
            boxShadow: [
              BoxShadow(
                color: kBlackColor.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(widget.imageAsset),
              ),
              const SizedBox(width: kMarginLg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: AppTextStyle.semibold(kTextSizeLg, textColor),
                    ),
                    if (widget.subtitle != null)
                      Padding(
                        padding: const EdgeInsets.only(top: kPaddingSm),
                        child: Text(
                          widget.subtitle!,
                          style: AppTextStyle.medium(kTextSizeSm, textColor),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
