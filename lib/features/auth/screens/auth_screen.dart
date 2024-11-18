import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_class_pal/features/auth/bloc/auth_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../core/constants/constant.dart';
import '../../../core/state/app_state.dart';
import '../../../core/utils/app_text_style.dart';
import '../../../core/widgets/common_widget/custom_button.dart';
import '../../../core/widgets/common_widget/custom_text_field.dart';
import '../../../core/widgets/common_widget/loading_dialog.dart';
import '../../../core/widgets/normal_widget/oval_image.dart';

class AuthScreen extends StatefulWidget {
  static const route = 'AuthScreen';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Existing controllers and variables
  TextEditingController _phoneOrEmailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _authMethodController = TextEditingController();

  final _role = AppState.currentRole;
  bool? _isPhone = false;
  String _gender = "Chọn giới tính";
  String _loginMethod = "Email";
  String _selectedMode = "Đăng nhập";

  @override
  void initState() {
    super.initState();
    _authMethodController.text = _loginMethod;
    _isPhone = _loginMethod == 'Số điện thoại';
    _phoneOrEmailController.addListener(_validateForm);
    _nameController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
    _confirmPasswordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _phoneOrEmailController.removeListener(_validateForm);
    _nameController.removeListener(_validateForm);
    _passwordController.removeListener(_validateForm);
    _confirmPasswordController.removeListener(_validateForm);
    super.dispose();
  }

  bool _isFormValid() {
    if (_selectedMode == "Đăng ký") {
      return _nameController.text.isNotEmpty &&
          _phoneOrEmailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty &&
          _passwordController.text == _confirmPasswordController.text;
    } else {
      return _phoneOrEmailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    }
  }

  void _validateForm() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(kBorderRadiusMd)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(kBorderRadiusMd)),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  OvalImage(
                    imagePath: _role == 'Phụ huynh'
                        ? 'assets/images/parent_teach.jpg'
                        : 'assets/images/class.jpg',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kPaddingXl),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: kMarginLg),
                        ToggleSwitch(
                          minWidth: double.infinity,
                          initialLabelIndex: _selectedMode == 'Đăng nhập' ? 0 : 1,
                          cornerRadius: 20.0,
                          activeFgColor: Colors.white,
                          inactiveBgColor: kPrimaryColor.withOpacity(0.5),
                          inactiveFgColor: Colors.white,
                          totalSwitches: 2,
                          labels: const ['ĐĂNG NHẬP', 'ĐĂNG KÝ'],
                          activeBgColors: const [
                            [kPrimaryColor],
                            [kPrimaryColor]
                          ],
                          onToggle: (index) {
                            setState(() {
                              _selectedMode = index == 0 ? 'Đăng nhập' : 'Đăng ký';
                            });
                          },
                        ),
                        const SizedBox(height: kMarginLg),
                        Text(
                          _selectedMode == "Đăng ký" ? "Đăng ký" : "Đăng Nhập",
                          style: AppTextStyle.bold(kTextSizeXxl),
                        ),
                        Text(
                          _selectedMode == "Đăng ký"
                              ? "Tạo một tài khoản ${_role?.toLowerCase()}"
                              : "Đăng nhập với tài khoản ${_role?.toLowerCase()}",
                          style: AppTextStyle.semibold(kTextSizeMd, kGreyColor),
                        ),
                        const SizedBox(height: kMarginXl),
                        if (_selectedMode == "Đăng ký") ...[
                          CustomTextField(
                            controller: _genderController,
                            text: _role == 'Phụ huynh' ? 'Cha/Mẹ' : 'Thầy/Cô',
                            options: _role == 'Phụ huynh' ? ["Cha", "Mẹ"] : ["Thầy", "Cô"],
                            height: 60.0,
                            onChanged: (selectedGender) {
                              setState(() {
                                _gender = selectedGender;
                                _genderController.text = _gender;
                              });
                            },
                          ),
                          const SizedBox(height: kMarginMd),
                          CustomTextField(
                              controller: _nameController,
                              text: "Họ và tên",
                              height: 60.0),
                        ],
                        const SizedBox(height: kMarginMd),
                        CustomTextField(
                          controller: _authMethodController,
                          text: 'Phương thức đăng nhập',
                          options: ["Email", "Số điện thoại"],
                          height: 60.0,
                          defaultValue: "Email",
                          onChanged: (selectedLoginMethod) {
                            setState(() {
                              _loginMethod = selectedLoginMethod;
                              _authMethodController.text = _loginMethod;
                              _isPhone = selectedLoginMethod == 'Số điện thoại';
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
                        CustomTextField(
                          controller: _passwordController,
                          text: "Mật khẩu",
                          isPassword: true,
                          height: 60.0,
                        ),
                        if (_selectedMode == "Đăng ký") ...[
                          const SizedBox(height: kMarginMd),
                          CustomTextField(
                              controller: _confirmPasswordController,
                              text: "Nhập lại mật khẩu",
                              isPassword: true,
                              height: 60.0),
                        ],
                        const SizedBox(height: kMarginLg),
                        Text(
                          "Mật khẩu phải bao gồm ít nhất 8 ký tự, bao gồm chữ và số",
                          style: AppTextStyle.medium(kTextSizeSm),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: kMarginLg),
                        BlocConsumer<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is AuthLoginInProgress) {
                              LoadingDialog.showLoadingDialog(context);
                            } else if (state is AuthLoginSuccess) {
                              LoadingDialog.hideLoadingDialog(context);
                              Navigator.pushReplacementNamed(context, '/home');
                            } else if (state is AuthRegisterSuccess) {
                              LoadingDialog.hideLoadingDialog(context);
                              setState(() {
                                _selectedMode = 'Đăng nhập';
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Đăng ký thành công!")),
                              );
                            } else if (state is AuthLoginFailure || state is AuthRegisterFailure) {
                              LoadingDialog.hideLoadingDialog(context);
                            }
                          },
                          builder: (context, state) {
                            return CustomButton(
                              text: _selectedMode == "Đăng ký" ? 'Tạo' : 'Đăng nhập',
                              isDisabled: state is AuthLoginInProgress || ! _isFormValid(),
                              onPressed: () {
                                if (_selectedMode == "Đăng ký") {
                                  if (_gender == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Vui lòng chọn giới tính")),
                                    );
                                    return;
                                  }
                                  context.read<AuthBloc>().add(
                                    AuthRegisterStarted(
                                      name: _nameController.text,
                                      email: _phoneOrEmailController.text,
                                      password: _passwordController.text,
                                      gender: _gender,
                                      role: _role!,
                                    ),
                                  );
                                } else {
                                  context.read<AuthBloc>().add(
                                    AuthLoginStarted(
                                      email: _phoneOrEmailController.text,
                                      password: _passwordController.text,
                                    ),
                                  );
                                }
                              },

                            );
                          },
                        ),
                        const SizedBox(height: kMarginLg),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(Iconsax.close_circle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
