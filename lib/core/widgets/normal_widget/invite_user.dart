import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../features/class/bloc/class_bloc.dart';
import '../../../features/student/model/student_model.dart';
import '../../constants/constant.dart';
import '../../utils/app_text_style.dart';
import '../common_widget/custom_button.dart';
import '../common_widget/custom_text_field.dart';  // Import Bloc package
import '../common_widget/loading_dialog.dart';  // Import LoadingDialog

class InviteUser extends StatefulWidget {
  final StudentModel? student;

  const InviteUser({super.key, this.student});

  @override
  State<InviteUser> createState() => _InviteUserState();
}

class _InviteUserState extends State<InviteUser> {
  TextEditingController _authMethodController = TextEditingController();
  TextEditingController _phoneOrEmailController = TextEditingController();

  bool? _isPhone = false;
  String _method = "Email";

  @override
  void initState() {
    super.initState();
    _authMethodController.text = _method;
    _phoneOrEmailController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _authMethodController.dispose();
    _phoneOrEmailController.dispose();
    super.dispose();
  }

  bool _isFormValid() {
    return _phoneOrEmailController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ClassBloc, ClassState>(
      listener: (context, state) {
        if (state is ClassInviteTeacherInProgress) {
          LoadingDialog();
        } else if (state is ClassInviteTeacherSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Lời mời đã được gửi thành công!')),
          );
        } else if (state is ClassInviteTeacherFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: kMarginLg),
        padding: const EdgeInsets.symmetric(horizontal: kPaddingLg, vertical: kPaddingLg),
        decoration: const BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.all(Radius.circular(kBorderRadiusLg)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    child: const FaIcon(FontAwesomeIcons.xmark),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Center(
                  child: Text(
                    'Gửi lời mời',
                    style: AppTextStyle.bold(kTextSizeLg),
                  ),
                ),
              ],
            ),
            if (widget.student != null) ...[
              const SizedBox(height: kMarginSm),
              Text(
                'P/h của ${widget.student?.name}',
                style: AppTextStyle.semibold(kTextSizeSm, kGreyColor),
              ),
            ],
            const SizedBox(height: kMarginLg),
            CustomTextField(
              controller: _authMethodController,
              text: 'Phương thức gửi',
              options: ["Email", "Số điện thoại"],
              height: 60.0,
              defaultValue: "Email",
              onChanged: (selectedMethod) {
                setState(() {
                  _method = selectedMethod;
                  _authMethodController.text = _method;
                  _isPhone = selectedMethod == 'Số điện thoại';
                });
              },
            ),
            const SizedBox(height: kMarginMd),
            CustomTextField(
              controller: _phoneOrEmailController,
              text: _isPhone == true ? "Số điện thoại" : "Email",
              isNumber: _isPhone ?? true,
              height: 60.0,
            ),
            const SizedBox(height: kMarginMd),
            CustomButton(
              text: 'Mời',
              isDisabled: !_isFormValid(),
              onPressed: () {
                // Gửi sự kiện để gửi lời mời qua Bloc
                BlocProvider.of<ClassBloc>(context).add(
                  ClassInviteTeacherStarted(
                    teacherEmail: _phoneOrEmailController.text,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
