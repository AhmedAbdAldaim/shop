import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/layout/cubit/layout_cubit.dart';
import 'package:shop/layout/cubit/layout_states.dart';
import 'package:shop/models/products_model.dart';
import 'package:shop/shared/components/components.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      LayoutCubit.get(context).getProducts();
      return BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          return Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: state is ProductsErrorState
                      ? const Center(child: Text('هناك خطا في الاتصال بالخادم'))
                      : ConditionalBuilder(
                          condition: cubit.productsModel != null &&
                              state is ProductsSuccessState,
                          builder: (context) {
                            return cubit
                                    .productsModel!.data!.productsList.isEmpty
                                ? const Center(child: Text('لا توجد منتجات'))
                                : GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 16.0,
                                            mainAxisSpacing: 16.0,
                                            childAspectRatio: 0.7),
                                    itemCount: cubit.productsModel!.data!
                                        .productsList.length,
                                    itemBuilder: (context, index) {
                                      return buildItemProduct(
                                          cubit.productsModel!.data!
                                              .productsList[index],
                                          cubit,
                                          context);
                                    });
                          },
                          fallback: (context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        )));
        },
      );
    });
  }

  Widget buildItemProduct(
      DataModel model, LayoutCubit cubit, BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: cubit.initMode
                            ? HexColor("#303030")
                            : HexColor("#c6c6c6"),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: () => navigetionBack(context: context),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red.shade900),
                              child: const Text('إغلاق'),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Image.asset(
                              'assets/images/placeholder.gif',
                              height: 300,
                              width: double.infinity,
                            ),
                            Text("أسم المنتج :",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: Colors.grey)),
                            Text(model.spName,
                                style: Theme.of(context).textTheme.titleMedium),
                            Text("وصف المنتج :",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: Colors.grey)),
                            Text(model.description,
                                style: Theme.of(context).textTheme.titleSmall),
                            Text("السعر :",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: Colors.grey)),
                            Text('${model.price}س.ج',
                                style: Theme.of(context).textTheme.titleSmall),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () {
                                    cubit.insertToProducts(
                                        id: model.id,
                                        name: model.spName,
                                        image: "assets/images/placeholder.gif",
                                        price: model.price);
                                  },
                                  child: const Text('اضف للسلة')),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            });
      },
      child: Container(
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
            color: cubit.initMode ? Colors.black45 : Colors.white70,
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: CachedNetworkImage(
                      fit: BoxFit.contain,
                      imageUrl: "https://encrypted-tbn0.gstatic.com/imagAU",
                      placeholder: (context, url) => Transform.scale(
                          scale: 0.3,
                          child: const CircularProgressIndicator.adaptive()),
                      errorWidget: (context, url, error) =>
                          Image.asset("assets/images/placeholder.gif")),
                ),
                Card(
                  elevation: 0.0,
                  color: Colors.amber,
                  child: Text(
                    '${model.price}س.ج',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.black),
                  ),
                ),
              ],
            ),
            Text(
              model.spName,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(overflow: TextOverflow.ellipsis),
              maxLines: 1,
            ),
            Expanded(
              child: Text(model.description,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.grey),
                  overflow: TextOverflow.ellipsis),
            ),
            ElevatedButton(
                onPressed: () {
                  cubit.insertToProducts(
                      id: model.id,
                      name: model.spName,
                      image: "assets/images/placeholder.gif",
                      price: model.price);
                },
                child: const Text('اضف للسلة'))
          ],
        ),
      ),
    );
  }
}
