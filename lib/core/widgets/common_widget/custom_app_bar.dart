import 'package:flutter/material.dart';

import '../../constants/constant.dart';
import '../../utils/app_text_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subtitle;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? subtitleColor;
  final Widget? leading;
  final VoidCallback? onLeadingTap;
  final List<Widget>? actions;
  final bool isTitleCenter;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  const CustomAppBar({
    Key? key,
    this.title,
    this.subtitle,
    this.backgroundColor = kWhiteColor,
    this.titleColor = kBlackColor,
    this.subtitleColor = kBlackColor,
    this.leading,
    this.onLeadingTap,
    this.actions,
    this.isTitleCenter = false,
    this.titleStyle,
    this.subtitleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingLg),
        alignment: Alignment.center,
        color: backgroundColor,
        child: SafeArea(
          child: isTitleCenter
              ? Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (title != null)
                            Text(
                              title!,
                              style: titleStyle ??
                                  AppTextStyle.semibold(
                                    kTextSizeMd,
                                    titleColor!,
                                  ),
                            ),
                          if (subtitle != null)
                            Text(
                              subtitle!,
                              style: subtitleStyle ??
                                  AppTextStyle.medium(
                                    kTextSizeSm,
                                    subtitleColor!,
                                  ),
                            ),
                        ],
                      ),
                    ),
                    Center(
                      child: Row(
                        children: [
                          if (leading != null)
                            GestureDetector(
                              onTap: onLeadingTap ??
                                  () => Navigator.of(context).pop(),
                              child: leading!,
                            ),
                          if (leading != null) const SizedBox(width: kMarginMd),
                          const Spacer(),
                          if (actions != null)
                            Row(
                              children: [
                                for (int i = 0; i < actions!.length; i++) ...[
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: kMarginMd),
                                    child: actions![i],
                                  ),
                                  if (i < actions!.length - 1)
                                    const SizedBox(width: kMarginMd),
                                ],
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    if (leading != null)
                      GestureDetector(
                        onTap:
                            onLeadingTap ?? () => Navigator.of(context).pop(),
                        child: leading!,
                      ),
                    if (leading != null) const SizedBox(width: kMarginMd),
                    if (actions != null)
                      Row(
                        children: [
                          for (int i = 0; i < actions!.length; i++) ...[
                            Padding(
                              padding: const EdgeInsets.only(left: kMarginMd),
                              child: actions![i],
                            ),
                            if (i < actions!.length - 1)
                              const SizedBox(width: kMarginMd),
                          ],
                        ],
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
