import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_class_pal/core/widgets/common_widget/loading_dialog.dart';
import 'package:flutter_class_pal/features/class/widgets/class_post_item.dart';
import 'package:flutter_class_pal/features/class/widgets/custom_button_create_post.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/widgets/common_widget/custom_app_bar.dart';
import '../../bloc/post_bloc/post_bloc.dart';
import '../../model/class_model.dart';
import '../class_post/class_create_post_screen.dart';
import '../../model/post_model.dart';

class ClassBoardPage extends StatelessWidget {
  static const route = 'ClassBoardPage';
  final ClassModel classData;

  const ClassBoardPage({super.key, required this.classData});

  @override
  Widget build(BuildContext context) {
    // Trigger fetch posts when the page is built
    BlocProvider.of<PostBloc>(context).add(PostFetchStarted());

    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kPaddingMd),
                      child: CustomButtonCreatePost(
                        avatarImage: 'assets/images/boy.jpg',
                        avatarText: null,
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return const FractionallySizedBox(
                                alignment: Alignment.bottomCenter,
                                heightFactor: 0.95,
                                child: ClassCreatePostScreen(),
                              );
                            },
                          ).then((_) {
                            // Fetch posts again after creating a post
                            BlocProvider.of<PostBloc>(context).add(PostFetchStarted());
                          });
                        },
                      ),
                    ),
                    if (state is PostFetchSuccess) ...[
                      ...state.posts.map((post) {
                        return ClassPostItem(post: post);
                      }).toList(),
                    ] else if (state is PostFetchFailure) ...[
                      Center(child: Text('Failed to fetch posts:')),
                    ] else if (state is PostFetchInProgress) ...[
                      // Không cần xử lý loading ở đây, sẽ hiển thị ở Stack
                    ] else ...[
                      Center(child: Text('No posts available.')),
                    ],
                  ],
                ),
              ),
              if (state is PostFetchInProgress) ...[
                LoadingDialog(),
              ],
            ],
          );
        },
      ),
    );
  }

  CustomAppBar _buildAppBar() {
    return CustomAppBar(
      title: 'Bảng tin',
      leading: const FaIcon(
        FontAwesomeIcons.arrowLeft,
        size: 20,
      ),
      titleStyle: AppTextStyle.bold(kTextSizeXl),
      isTitleCenter: true,
    );
  }
}