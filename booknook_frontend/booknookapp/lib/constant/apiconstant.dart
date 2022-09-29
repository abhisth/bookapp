class ApiUrl {
  String baseApi = 'http://192.168.1.64';
  String get signupURL => baseApi + '/user/register';
  String get adminLoginURL => baseApi + '/admin/login';
  String get userLoginURL => baseApi + '/user/login';
  String get getProductURL => baseApi + '/product';
  String get getUserURL => baseApi + '/user';
  String get getUserCartURL => baseApi + '/user/cart';
  String get addRemoveCartItem => baseApi + '/user/cart/';
  String get checkoutOrder => baseApi + '/user/checkout';
  String get deleteProduct => baseApi + '/product/delete/';
  String get addProduct => baseApi + '/product';
  String get updateProduct => baseApi + '/product/edit/';
  String get uploadProductPhoto => baseApi + '/product/image/';
}
