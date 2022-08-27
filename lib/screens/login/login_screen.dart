import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shop/layout/layout_screen.dart';
import 'package:shop/screens/login/cubit/login_cubit.dart';
import 'package:shop/screens/login/cubit/login_states.dart';
import 'package:shop/screens/redgister/register_screen.dart';
import 'package:shop/shared/components/components.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            context.loaderOverlay.hide();
            defautToast(message: 'هناك خطأ في الإتصال بالخادم');
          }
          if (state is LoginSuccessState) {
            if (state.loginModel.status == true) {
              navigatorAndRemive(context: context, page: const LayoutScreen());
            } else {
              context.loaderOverlay.hide();
              defautToast(message: 'البريد او كلمة المرور غير صحيحة!');
            }
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
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
                                        cubit.postLogin(
                                            email: emailController.text,
                                            password: passwordController.text);
                                      }
                                    },
                                    child: const Text('تسجيل دخول')))
                            ,const SizedBox(height: 10.0,),
                            InkWell(
                              onTap: ()=> navigetTo(context: context, page: RegisterScreen()),
                              child:  const Text('ليس لديك حساب , سجل الان!'),
                            )
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
