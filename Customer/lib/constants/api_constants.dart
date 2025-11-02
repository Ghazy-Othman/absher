//
//
//
class ApiConstants {
  ///
  static const String baseUrl = "http://192.168.43.56:8000/api/v1";
  /// Websocket
  static const String websocketHost = "192.168.43.56";
  static const String websocketPort = "8080";
  static const String websocketAppKey = "0suzb1x9lrcrempctyjx";
  static const String websocketUrl = "ws://$websocketHost:$websocketPort/app/$websocketAppKey" ;
  /// User
  static const String signUp = "$baseUrl/users/auth/register" ;
  static const String login = "$baseUrl/users/auth/login" ;
  static const String logout = "$baseUrl/users/auth/logout" ;
  static const String me = "$baseUrl/users/auth/me" ;
  static const String forgetPassword = "$baseUrl/users/auth/forget-password" ;
  static const String resetPassword = "$baseUrl/users/auth/reset-password" ;
  ///
  static const String getProducts = "$baseUrl/products/for-customer" ;

  /// Cart
  static const String getUserCart = "$baseUrl/carts" ;
  static String getCart(int cartId) => "$baseUrl/carts/$cartId" ;
  static String deleteCart(int cartId) => "$baseUrl/carts/$cartId" ;

  /// Products
  static const String getProduct = "$baseUrl/products/{product_id}" ;
  static const String getProductsByCategory = "$baseUrl/products/category/{category_id}" ;


  /// Cart Items
  static const String addItemToCart = "$baseUrl/carts/items" ;
  static String updateCartItemQuantity(int cartItemId) => "$baseUrl/carts/items/$cartItemId" ;
  static String deleteCartItem(int cartItemId) => "$baseUrl/carts/items/$cartItemId" ;
  static String checkout(int cartId) => "$baseUrl/carts/$cartId/checkout" ;

  ///
  static const String getUserOrders ="$baseUrl/orders/customer" ;
  static const String getOrder ="$baseUrl/orders/{order_id}" ;
  static const String generateCode = "$baseUrl/orders/{order_id}/otp/deliver/generate" ;
}
