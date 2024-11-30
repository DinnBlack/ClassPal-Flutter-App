import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_class_pal/core/state/app_state.dart';
import 'package:flutter_class_pal/core/widgets/common_widget/loading_dialog.dart';
import 'package:flutter_class_pal/features/user/model/user_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../core/constants/constant.dart';
import '../core/utils/app_text_style.dart';
import '../core/widgets/common_widget/custom_app_bar.dart';
import '../core/widgets/common_widget/custom_list_item.dart';
import '../features/class/bloc/class_bloc/class_bloc.dart';
import '../features/class/screens/class_create/class_create_screen.dart';
import '../features/class/screens/class_main_screen.dart';

class MainScreen extends StatefulWidget {
  static const route = 'MainScreen';

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final UserModel? currentUser = AppState.getUser();

  @override
  void initState() {
    super.initState();
    final classBloc = BlocProvider.of<ClassBloc>(context);
    classBloc.add(ClassFetchStarted());
    classBloc.fetchStream.listen((_) {
      classBloc.add(ClassFetchStarted());
    });
  }

  void showTopSheet(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.topCenter,
          child: Material(
            color: Colors.transparent,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 0),
              decoration: const BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(kBorderRadiusMd),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(kPaddingMd),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
              .animate(animation),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClassBloc, ClassState>(
      listener: (context, state) {
        if (state is ClassFetchFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to fetch classes')),
          );
        }
      },
      builder: (context, state) {
        if (state is ClassFetchInProgress) {
          return const LoadingDialog();
        }

        if (state is ClassFetchSuccess) {
          var classes = state.classes;
          return Scaffold(
            backgroundColor: kBackgroundColor,
            appBar: CustomAppBar(
              leading: GestureDetector(
                onTap: () {
                  BlocProvider.of<ClassBloc>(context).add(ClassFetchStarted());
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: kPrimaryColor,
                      child: FaIcon(
                        FontAwesomeIcons.solidUser,
                        size: 18,
                      ),
                    ),
                    SizedBox(width: kMarginSm),
                    FaIcon(
                      FontAwesomeIcons.chevronDown,
                      size: 14,
                    ),
                  ],
                ),
              ),
              onLeadingTap: () {
                print("Menu tapped");
              },
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(kPaddingMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Xin chào",
                      style: AppTextStyle.semibold(kTextSizeMd, kGreyColor),
                    ),
                    Text(
                      "${currentUser?.gender} ${currentUser?.name}",
                      style: AppTextStyle.semibold(kTextSizeXl),
                    ),
                    const SizedBox(height: kMarginXl),
                    Text("Trường học",
                        style: AppTextStyle.semibold(kTextSizeMd)),
                    const SizedBox(height: kMarginMd),
                    if (currentUser?.schoolsIds == null ||
                        currentUser?.schoolsIds?.isEmpty == true)
                      CustomListItem(
                        title: 'Thêm trường',
                        titleStyle:
                            AppTextStyle.semibold(kTextSizeSm, kPrimaryColor),
                        customLeadingWidget: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: kPrimaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: kWhiteColor,
                            size: 24,
                          ),
                        ),
                      ),
                    CustomListItem(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return const FractionallySizedBox(
                              alignment: Alignment.bottomCenter,
                              heightFactor: 0.95,
                              child: ClassCreateScreen(),
                            );
                          },
                        );
                      },
                      title: 'Tham gia lớp',
                      titleStyle: AppTextStyle.semibold(
                        kTextSizeSm,
                        kBlueColor,
                      ),
                      customLeadingWidget: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFF10B1E8),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          FontAwesomeIcons.userTie,
                          color: kWhiteColor,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(height: kMarginMd),
                    Text("Lớp học của bạn",
                        style: AppTextStyle.semibold(kTextSizeMd)),
                    const SizedBox(height: kMarginMd),
                    if (classes.isNotEmpty)
                      Column(
                        children: classes
                            .map(
                              (classItem) => CustomListItem(
                                imageUrl: 'assets/images/class.png',
                                title: classItem.className,
                                subtitle: 'THPT Long Bình',
                                textColor: Colors.black,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    ClassMainScreen.route,
                                    arguments: classItem,
                                  );
                                  AppState.setClass(classItem);
                                },
                                trailingIcon: true,
                              ),
                            )
                            .toList(),
                      ),
                    CustomListItem(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return const FractionallySizedBox(
                              alignment: Alignment.bottomCenter,
                              heightFactor: 0.95,
                              child: ClassCreateScreen(),
                            );
                          },
                        );
                      },
                      title: 'Thêm lớp',
                      titleStyle:
                          AppTextStyle.semibold(kTextSizeSm, kPrimaryColor),
                      customLeadingWidget: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: kPrimaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: kWhiteColor,
                          size: 24,
                        ),
                      ),
                    ),
                    CustomListItem(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return const FractionallySizedBox(
                              alignment: Alignment.bottomCenter,
                              heightFactor: 0.95,
                              child: ClassCreateScreen(),
                            );
                          },
                        );
                      },
                      title: 'Tham gia lớp',
                      titleStyle: AppTextStyle.semibold(
                        kTextSizeSm,
                        kBlueColor,
                      ),
                      customLeadingWidget: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFF10B1E8),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          FontAwesomeIcons.userTie,
                          color: kWhiteColor,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is ClassFetchFailure) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.red),
                SizedBox(height: 8),
                Text('Failed to load classes'),
              ],
            ),
          );
        }

        return const Center(
          child: Text('Đang tải dữ liệu...'),
        );
      },
    );
  }
}
