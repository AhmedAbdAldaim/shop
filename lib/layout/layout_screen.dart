import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/layout_cubit.dart';
import 'package:shop/layout/cubit/layout_states.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(title: Text(cubit.titles[cubit.initindex]),),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index)=> cubit.chanegBottomNavigationBar(index: index),
              currentIndex: cubit.initindex,
              items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopify_rounded), label: 'المنتجات'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: 'سلة المنتجات'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopify_rounded), label: 'الخدمات'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: 'سلة الخدمات'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded), label: 'حسابي'),
            ]),
            body: cubit.screens[cubit.initindex],
          ),
        );
      },
    );
  }
}
