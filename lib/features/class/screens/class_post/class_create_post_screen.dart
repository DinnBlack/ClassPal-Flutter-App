import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/state/app_state.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/widgets/common_widget/loading_dialog.dart';
import '../../bloc/post_bloc/post_bloc.dart';
import '../../model/post_model.dart';

class ClassCreatePostScreen extends StatefulWidget {
  const ClassCreatePostScreen({super.key});

  @override
  State<ClassCreatePostScreen> createState() => _ClassCreatePostScreenState();
}

class _ClassCreatePostScreenState extends State<ClassCreatePostScreen> {
  final TextEditingController _contentController = TextEditingController();
  List<File> selectedImages = [];

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  void _addImage(File image) {
    setState(() {
      selectedImages.add(image);
    });
  }

  void _removeImage(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(kBorderRadiusMd)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(kPaddingMd),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: const FaIcon(FontAwesomeIcons.xmark),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Center(
                    child: Text(
                      'Tạo bài đăng',
                      style: AppTextStyle.bold(kTextSizeLg),
                    ),
                  ),

                  BlocConsumer<PostBloc, PostState>(
                    listener: (context, state) {
                      if (state is PostCreateInProgress) {
                        LoadingDialog.showLoadingDialog(context);
                      } else if (state is PostCreateSuccess ||
                          state is PostCreateFailure) {
                        LoadingDialog.hideLoadingDialog(context);

                        if (state is PostCreateSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Lớp học đã được tạo thành công')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Tạo lớp học thất bại')),
                          );
                        }

                        Navigator.pop(context);
                        context.read<PostBloc>().add(PostResetStarted());
                      }
                    },
                    builder: (context, state) {
                      return InkWell(
                        child: const FaIcon(FontAwesomeIcons.check),
                        onTap: () {
                          PostModel newPost = PostModel(
                            userId: AppState.getUser()!.userId,
                            createdAt: DateTime.now(),
                            content: _contentController.text,
                          );

                          context.read<PostBloc>().add(PostCreateStarted(newPost: newPost));
                        },
                      );
                    },
                  ),

                ],
              ),
            ),
            Container(
              color: kLightGreyColor,
              width: double.infinity,
              height: 1,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(kPaddingMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _contentController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Bạn đang nghĩ gì?',
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: kMarginMd),
                    // Display Selected Images
                    if (selectedImages.isNotEmpty)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: selectedImages
                            .asMap()
                            .entries
                            .map(
                              (entry) => Stack(
                                children: [
                                  Image.file(
                                    entry.value,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () => _removeImage(entry.key),
                                      child: const CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Colors.red,
                                        child: Icon(
                                          Icons.close,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
