import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/layout_cubit.dart';
import 'package:shop/layout/cubit/layout_states.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/sharedpre_helper.dart';

class ServicesBasketScreen extends StatelessWidget {
  const ServicesBasketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      LayoutCubit.get(context).getServicesSqlite();
      return BlocConsumer<LayoutCubit, LayoutStates>(
          listener: (context, state) {
        if (state is OrdersSuccessState) {
          LayoutCubit.get(context).deleteAllServices();
          defautToast(message: "تم الطلب بنجاح!");
        }
      }, builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        return Scaffold(
            body: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: [
                    cubit.getAllBsketServices.isNotEmpty ||
                            cubit.totalPriceSer != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              cubit.totalPriceSer != null
                                  ? Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: IconButton(
                                          onPressed: () {
                                            cubit.deleteAllServices();
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
                                    Text(cubit.totalPriceSer.toString(),
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
                      child: cubit.getAllBsketServices.isEmpty
                          ? Center(child: Text("السلة خالية"))
                          : ListView.builder(
                              itemCount: cubit.getAllBsketServices.length,
                              itemBuilder: (context, index) {
                                return buildItemBasketServices(
                                    cubit.getAllBsketServices[index],
                                    context,
                                    cubit);
                              }),
                    ),
                    cubit.getAllBsketServices.isNotEmpty ||
                            cubit.totalPriceSer != null
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () {
                                      for (var element in cubit.getAllBsketServices) {
                                         cubit.postOrders(
                                            userId: SharedPreHelper.getData(key: 'id'),
                                            serId: element['id'],);
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

  Widget buildItemBasketServices(model, context, LayoutCubit cubit) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () async {
                  await cubit.deleteItemServices(id: model['id']);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red.shade800,
                )),
            ListTile(
              leading: Image.asset(model['image']),
              title: Text(model['name'],
                  maxLines: 1, style: Theme.of(context).textTheme.bodySmall),
             
              trailing: Text((model['price']).toString(),
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
          ],
        ),
      ),
    );
  }
}
