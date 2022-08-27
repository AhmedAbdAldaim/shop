import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/layout_cubit.dart';
import 'package:shop/layout/cubit/layout_states.dart';
import 'package:shop/screens/services_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/sharedpre_helper.dart';

class ProductsBasketScreen extends StatelessWidget {
  const ProductsBasketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      LayoutCubit.get(context).getProductsSqlite();
      return BlocConsumer<LayoutCubit, LayoutStates>(
          listener: (context, state) {
        if (state is PurecachesSuccessState) {
          LayoutCubit.get(context).deleteAllProducts();
          defautToast(message: "تم الطلب بنجاح!");
        }
      }, builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        
        return Scaffold(
            body: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: [
                    cubit.getAllBsketProducts.isNotEmpty ||
                            cubit.totalPrice != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              cubit.totalPrice != null
                                  ? Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: IconButton(
                                          onPressed: () {
                                            cubit.deleteAllProducts();
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red.shade800,
                                          )),
                                    )
                                  : const SizedBox(
                                      height: 0.0,
                                    ),
                              Card(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "المجموع : ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    Text(cubit.totalPrice.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold))
                                  ],
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(
                            height: 0.0,
                          ),
                    Expanded(
                      child: cubit.getAllBsketProducts.isEmpty
                          ? Center(child: Text("السلة خالية"))
                          : ListView.builder(
                              itemCount: cubit.getAllBsketProducts.length,
                              itemBuilder: (context, index) {
                                return buildItemBasketProducts(
                                    cubit.getAllBsketProducts[index],
                                    context,
                                    cubit);
                              }),
                    ),
                    cubit.getAllBsketProducts.isNotEmpty ||
                            cubit.totalPrice != null
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () {
                                      for (var element
                                          in cubit.getAllBsketProducts) {
                                        cubit.postPurecaches(
                                            userId: SharedPreHelper.getData(
                                                key: 'id'),
                                            spId: element['id'],
                                            quantity: element['amount']);
                                      }
                                    },
                                    child: Text('طلب'))),
                          )
                        : const SizedBox(
                            height: 0.0,
                          )
                  ],
                )));
      });
    });
  }

  Widget buildItemBasketProducts(model, context, LayoutCubit cubit) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () async {
                  await cubit.deleteItemProducts(id: model['id']);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red.shade800,
                )),
            ListTile(
              leading: Image.asset(model['image']),
              title: Text(model['name'],
                  maxLines: 1, style: Theme.of(context).textTheme.bodySmall),
              subtitle: Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        await cubit.incrementupdateAmount(
                          id: model['id'],
                          amount: model['amount'] + 1,
                        );
                      },
                      icon: const CircleAvatar(
                          radius: 30, child: Icon(Icons.add))),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(model['amount'].toString(),
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                  IconButton(
                      onPressed: () async {
                        await cubit.decrementupdateAmount(
                          id: model['id'],
                          amount: model['amount'] - 1,
                        );
                      },
                      icon: const CircleAvatar(
                          radius: 30, child: Icon(Icons.remove))),
                ],
              ),
              trailing: Text((model['price'] * model['amount']).toString(),
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
          ],
        ),
      ),
    );
  }
}
