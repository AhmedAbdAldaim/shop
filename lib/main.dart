import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/layout_cubit.dart';
import 'package:shop/layout/cubit/layout_states.dart';
import 'package:shop/layout/layout_screen.dart';
import 'package:shop/screens/login/login_screen.dart';
import 'package:shop/screens/redgister/register_screen.dart';
import 'package:shop/shared/network/local/sharedpre_helper.dart';
import 'package:shop/shared/observer.dart';
import 'package:shop/shared/style/theme.dart';

void main() {
  BlocOverrides.runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SharedPreHelper.initSharedPredFrencese();
    //VERTICAL ONLY
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    runApp(MyApp());
  }, blocObserver: MyBlocObserver());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  bool? mode = SharedPreHelper.getData(key: 'mode');

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LayoutCubit()..changeDarkMode(mode)..createDb())
      ],
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: cubit.initMode ? Colors.black : Colors.white,
            statusBarIconBrightness:
                cubit.initMode ? Brightness.light : Brightness.dark,
            systemNavigationBarIconBrightness:
                cubit.initMode ? Brightness.light : Brightness.dark,
          ));
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: cubit.initMode ? darkTheme : ligthTheme,
            themeMode: cubit.initMode ? ThemeMode.dark : ThemeMode.light,
            home: LoginScreen(),
          );
        },
      ),
    );
  }
}
