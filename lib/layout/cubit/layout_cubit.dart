import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/layout_states.dart';
import 'package:shop/models/login_model.dart';
import 'package:shop/models/orders_model.dart';
import 'package:shop/models/products_model.dart';
import 'package:shop/models/purecaches_model.dart';
import 'package:shop/models/register_model.dart';
import 'package:shop/models/services_model.dart';
import 'package:shop/screens/Products%20basket_screen.dart';
import 'package:shop/screens/products_screen.dart';
import 'package:shop/screens/profile_screen.dart';
import 'package:shop/screens/service_basket_screen.dart';
import 'package:shop/screens/services_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/sharedpre_helper.dart';
import 'package:shop/shared/network/local/sqlite_helper.dart';
import 'package:shop/shared/network/remote/http_endpoints.dart';
import 'package:shop/shared/network/remote/http_helper.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(InitLayoutState());
  static LayoutCubit get(context) => BlocProvider.of(context);

  //change BottomNavigationBar
  int initindex = 0;
  List<Widget> screens = const [
    ProductsScreen(),
    ProductsBasketScreen(),
    ServicesScreen(),
    ServicesBasketScreen(),
    ProfileScreen()
  ];
  List<String> titles = const [
    "كل المنتجات",
    "سلة المنتجات",
    "كل الخدمات",
    "سلة الخدمات",
    "الملف الشخصي",
  ];
  chanegBottomNavigationBar({required int index}) {
    initindex = index;
    emit(ChangeBottomNavBarState());
  }

  //change Dark Mode
  bool initMode = true;
  changeDarkMode(bool? fromshared) {
    if (fromshared != null) {
      initMode = fromshared;
    } else {
      initMode = !initMode;
      SharedPreHelper.setData(key: 'mode', value: initMode).then((value) {
        emit(ChangeDarkModeState());
      });
    }
  }

// get All Products
  ProductsModel? productsModel;
  getProducts() {
    emit(ProductsLoadingState());
    HttpHelper.getData(url: aspire).then((value) {
      productsModel = ProductsModel.fromJson(jsonDecode(value.body));
      print(jsonDecode(value.body));
      emit(ProductsSuccessState());
    }).catchError((error) {
      print(error);
      emit(ProductsErrorState());
    });
  }

// get All Service
  ServicesModel? servicesModel;
  getService() {
    emit(ServicesLoadingState());
    HttpHelper.getData(url: services).then((value) {
      servicesModel = ServicesModel.fromJson(jsonDecode(value.body));
      print(jsonDecode(value.body));
      emit(ServicesSuccessState());
    }).catchError((error) {
      print(error);
      emit(ServicesErrorState());
    });
  }

// post Purecache
  PurecachesModel? purecachesModel;
  postPurecaches({
    required int userId,
    required int spId,
    required int quantity,
  }) {
    emit(PurecachesLoadingState());
    print(spId);
    HttpHelper.postData(
            url: purecaches,
            data: {"user_id": userId, "sp_id": spId, "quantity": quantity})
        .then((value) {
      purecachesModel = PurecachesModel.fromJson(jsonDecode(value.body));
      emit(PurecachesSuccessState());
    }).catchError((error) {
      print(error);
      emit(PurecachesErrorState());
    });
  }

// post Orders
  OrdersModel? ordersModel;
  postOrders({
    required int userId,
    required int serId,
  }) {
    emit(OrdersLoadingState());

    HttpHelper.postData(url: orders, data: {
      "user_id": userId,
      "service_id": serId,
      "car_model": "خالية",
      "location": "الخرطوم"
    }).then((value) {
      ordersModel = OrdersModel.fromJson(jsonDecode(value.body));
      emit(OrdersSuccessState());
    }).catchError((error) {
      print(error);
      emit(OrdersErrorState());
    });
  }

// SqlIte
//create db
  createDb() {
    SqliteHelpr.createDatabase().then((value) {
      print("created Success");
      getProductsSqlite();
      getServicesSqlite();
    }).catchError((error) {
      print(error);
    });
  }

  insertToProducts(
      {required int id,
      required String name,
      required String image,
      required int price}) {
    SqliteHelpr.insertProductsDb(id, id, name, image, price, 1).then((value) {
      print("insert Done!");
      getProductsSqlite();
    }).catchError((error) {
      print(error);
      defautToast(message: 'تم الإضافة مسبقا');
    });
  }

  insertToService(
      {required int id,
      required String name,
      required String image,
      required int price}) {
    SqliteHelpr.insertServiceDb(id, id, name, image, price).then((value) {
      print("insert Done!");
      getServicesSqlite();
    }).catchError((error) {
      print(error);
      defautToast(message: 'تم الإضافة مسبقا');
    });
  }

  var getAllBsketProducts = [];
  var getAllBsketServices = [];
  getProductsSqlite() {
    SqliteHelpr.getAllProducts().then((value) {
      print(value);
      getAllBsketProducts = [];
      getAllBsketProducts.addAll(value);
      countProducts();
    }).catchError((error) {
      print((error));
    });
  }

  getServicesSqlite() {
    SqliteHelpr.getAllServices().then((value) {
      print(value);
      getAllBsketServices = [];
      getAllBsketServices.addAll(value);
      countServices();
    }).catchError((error) {
      print((error));
    });
  }

  deleteAllProducts() {
    SqliteHelpr.deleteAllProducts().then((value) {
      getAllBsketProducts = [];
      totalPrice = null;
      emit(DeleteAllProductsSqliteState());
    });
  }

  deleteAllServices() {
    SqliteHelpr.deleteAllService().then((value) {
      getAllBsketServices = [];
      totalPriceSer = null;
      emit(DeleteAllServicesSqliteState());
    });
  }

  deleteItemProducts({required int id}) {
    SqliteHelpr.deleteItemProducts(id).then((value) {
      getProductsSqlite();
      emit(DelItemProductsSqliteState());
    });
  }

  deleteItemServices({required int id, context}) {
    SqliteHelpr.deleteItemService(id).then((value) {
      emit(DeleteAllServicesSqliteState());
      getServicesSqlite();

      emit(DeleteAllServicesSqliteState());
    });
  }

  incrementupdateAmount({required int id, required int amount}) {
    SqliteHelpr.updateAmmount(id, amount).then((value) {
      getProductsSqlite();
      countProducts();
      emit(IncProductsSqliteState());
    }).catchError((error) {
      print(error);
    });
  }

  decrementupdateAmount({required int id, required int amount}) {
    if (amount >= 1) {
      SqliteHelpr.updateAmmount(id, amount).then((value) {
        getProductsSqlite();
        countProducts();
        emit(DecProductsSqliteState());
      }).catchError((error) {
        print(error);
      });
    }
  }

  int? totalPrice;
  countProducts() {
    SqliteHelpr.getCountPriceProducts().then((value) {
      for (var element in value) {
        totalPrice = element['SUM(price*amount)'];
      }
    });
  }

  int? totalPriceSer;
  countServices() {
    SqliteHelpr.getCountPriceServices().then((value) {
      for (var element in value) {
        totalPriceSer = element['SUM(price)'];
      }
    });
  }
}
