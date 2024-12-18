import 'package:flutter/material.dart';
import 'package:flutter_class_pal/core/constants/constant.dart';
import 'package:flutter_class_pal/core/utils/app_text_style.dart';
import 'package:flutter_class_pal/core/widgets/normal_widget/custom_avatar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../model/post_model.dart';

class ClassPostItem extends StatelessWidget {
  final PostModel post;

  const ClassPostItem({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('vi', timeago.ViMessages());

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(kPaddingMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  CustomAvatar(
                    text: post.user.name,
                  ),
                  const SizedBox(width: kMarginMd),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.user.name,
                        style: AppTextStyle.semibold(kTextSizeMd),
                      ),
                      Text(
                        timeago.format(post.createdAt, locale: 'vi'),
                        style: AppTextStyle.regular(kTextSizeXs, kGreyColor),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(FontAwesomeIcons.ellipsis),
                ],
              ),
              const SizedBox(height: kMarginLg),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.content,
                    style: AppTextStyle.medium(kTextSizeSm),
                  ),
                  if (post.image != null && post.image!.isNotEmpty) ...[
                    const SizedBox(height: 8.0),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: post.image!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Image.network(
                              post.image![index],
                              fit: BoxFit.cover,
                              width: 100,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: kMarginLg),
              // Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.heart,
                        size: 18,
                      ),
                      const SizedBox(width: kMarginMd),
                      Text(
                        '${post.likes} lượt thích',
                        style: AppTextStyle.regular(kTextSizeSm),
                      ),
                    ],
                  ),
                  Text(
                    '${post.views} lượt xem',
                    style: AppTextStyle.regular(kTextSizeSm),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: kMarginSm,
          width: double.infinity,
          color: kLightGreyColor.withOpacity(0.1),
        )
      ],
    );
  }
}
