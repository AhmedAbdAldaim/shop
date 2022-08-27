import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/layout/cubit/layout_cubit.dart';
import 'package:shop/layout/cubit/layout_states.dart';
import 'package:shop/screens/login/login_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/sharedpre_helper.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        print(cubit.initMode);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  color: cubit.initMode ? Colors.black45 : Colors.white70,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  defaultListTitle(
                      leading: const Icon(Icons.dark_mode),
                      title: const Text('الوضع الليلي'),
                      trailing: Switch(
                          value: cubit.initMode,
                          onChanged: (bool value) {
                            cubit.changeDarkMode(null);
                          })),
                  const Divider(
                    height: 5.0,
                  ),
                  InkWell(
                    onTap: () => navigatorAndRemive(
                        context: context, page: LoginScreen()),
                    child: defaultListTitle(
                        leading: const Icon(Icons.logout_rounded),
                        title: const Text('تسجيل خروج'),
                        trailing: const Icon(Icons.arrow_back_ios_new_rounded)),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
