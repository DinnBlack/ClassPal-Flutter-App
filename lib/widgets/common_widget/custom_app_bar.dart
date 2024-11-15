import 'package:flutter/material.dart';
import 'package:flutter_class_pal/utils/constants/constant.dart';

import '../../utils/ui_util/app_text_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<IconData> icons;
  final List<VoidCallback> iconActions;
  final String title;
  final String? subtitle;
  final Color backgroundColor;
  final bool showBackIcon;
  final Color titleColor;
  final Color subtitleColor;

  CustomAppBar({
    Key? key,
    required this.icons,
    required this.iconActions,
    required this.title,
    this.subtitle,
    this.backgroundColor = kWhiteColor,
    this.showBackIcon = true,
    this.titleColor = kBlackColor,
    this.subtitleColor = kBlackColor,
  })  : assert(icons.length == iconActions.length,
            'Each icon should have an associated action'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingMd),
        color: backgroundColor,
        child: SafeArea(
          child: Row(
            children: [
              if (showBackIcon) ...[
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.arrow_back, color: Colors.black),
                ),
                const SizedBox(width: kMarginMd),
              ],
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyle.semibold(
                        kTextSizeMd,
                        titleColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: AppTextStyle.medium(
                          kTextSizeSm,
                          subtitleColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                children: List.generate(icons.length, (index) {
                  return Row(
                    children: [
                      const SizedBox(width: kMarginMd,),
                      InkWell(
                        onTap: iconActions[index],
                        child: Icon(icons[index], color: Colors.black),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
