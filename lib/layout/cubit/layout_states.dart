abstract class LayoutStates {}
class InitLayoutState extends LayoutStates{}
class ChangeBottomNavBarState extends LayoutStates{}
class ChangeDarkModeState extends LayoutStates{}


//get All Products
class ProductsLoadingState extends LayoutStates{}
class ProductsSuccessState extends LayoutStates{}
class ProductsErrorState extends LayoutStates{}

//get All Services
class ServicesLoadingState extends LayoutStates{}
class ServicesSuccessState extends LayoutStates{}
class ServicesErrorState extends LayoutStates{}


//post purecaches
class PurecachesLoadingState extends LayoutStates{}
class PurecachesSuccessState extends LayoutStates{}
class PurecachesErrorState extends LayoutStates{}

//post orders
class OrdersLoadingState extends LayoutStates{}
class OrdersSuccessState extends LayoutStates{}
class OrdersErrorState extends LayoutStates{}

// sqlit
class IncProductsSqliteState extends LayoutStates{}
class DecProductsSqliteState extends LayoutStates{}
class DeleteAllProductsSqliteState extends LayoutStates{}
class DelItemProductsSqliteState extends LayoutStates{}

class IncServicesSqliteState extends LayoutStates{}
class DecServicesSqliteState extends LayoutStates{}
class DeleteAllServicesSqliteState extends LayoutStates{}
class DelItemServicesSqliteState extends LayoutStates{}

