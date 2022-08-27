import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shop/layout/cubit/layout_cubit.dart';
import 'package:shop/layout/cubit/layout_states.dart';
import 'package:shop/layout/layout_screen.dart';
import 'package:shop/screens/redgister/cubit/register_cubit.dart';
import 'package:shop/screens/redgister/cubit/register_states.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/sharedpre_helper.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterErrorState) {
            context.loaderOverlay.hide();
            defautToast(message: 'هناك خطأ في الإتصال بالخادم');
          }
          if (state is RegisterSuccessState) {
            SharedPreHelper.setData(
                key: 'name', value: state.registerModel.userModel.name);
            SharedPreHelper.setData(
                    key: 'id', value: state.registerModel.userModel.id)
                .then((value) {
              context.loaderOverlay.hide();
              navigatorAndRemive(context: context, page: const LayoutScreen());
            });
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return LoaderOverlay(
            useDefaultLoading: true,
            overlayColor: Colors.black,
            overlayOpacity: 0.3,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Directionality(
                textDirection: TextDirection.rtl,
                child: SafeArea(
                    child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            defaultTextFormFailed(
                                controller: nameController,
                                hint: 'الاسم',
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "أدخل الاسم";
                                  }
                                  return null;
                                },
                                action: TextInputAction.next,
                                keyboard: TextInputType.name),
                            const SizedBox(
                              height: 10.0,
                            ),
                            defaultTextFormFailed(
                                controller: emailController,
                                hint: 'البريد الالكتروني',
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "أدخل البريد الالكتروني";
                                  }
                                  return null;
                                },
                                action: TextInputAction.next,
                                keyboard: TextInputType.emailAddress),
                            const SizedBox(
                              height: 10.0,
                            ),
                            defaultTextFormFailed(
                                controller: phoneController,
                                hint: 'رقم الهاتف',
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "أدخل رقم الهاتف";
                                  }
                                  return null;
                                },
                                action: TextInputAction.next,
                                keyboard: TextInputType.phone),
                            const SizedBox(
                              height: 10.0,
                            ),
                            defaultTextFormFailed(
                                controller: passwordController,
                                hint: 'كلمة المرور',
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "أدخل كلمة المرور";
                                  }

                                  return null;
                                },
                                action: TextInputAction.done,
                                keyboard: TextInputType.text,
                                obscureText: cubit.ispasswordVisibility,
                                iconPassword: cubit.ispasswordVisibility == true
                                    ? const Icon(Icons.visibility, color: Colors.grey,)
                                    : const Icon(Icons.visibility_off, color: Colors.grey,),
                                onpressed: () {
                                  cubit.changePasswordvisibility();
                                }),
                            const SizedBox(
                              height: 10.0,
                            ),
                            SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(12.0)),
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                          context.loaderOverlay.show();
                                        cubit.postRegister(
                                            name: nameController.text,
                                            email: emailController.text,
                                            phone: phoneController.text,
                                            password: passwordController.text);
                                      }
                                    },
                                    child: const Text('إنشاء حساب')))
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
              ),
            ),
          );
        },
      ),
    );
  }
}
