//
//
//
class ApiConstant {
  ///
  static const String baseUrl = 'http://192.168.43.56:8000/api/v1';

  /// Websocket
  static const String websocketHost = "192.168.43.56";
  static const String websocketPort = "8080";
  static const String websocketAppKey = "0suzb1x9lrcrempctyjx";
  static const String websocketUrl = "ws://$websocketHost:$websocketPort/app/$websocketAppKey" ;

  /// User
  static const String register = "$baseUrl/users/auth/register";
  static const String login = "$baseUrl/users/auth/login";
  static const String logout = "$baseUrl/users/auth/logout";
  static const String me = "$baseUrl/users/auth/me";
  static const String forgetPassword = "$baseUrl/users/auth/forget-password" ;
  static const String resetPassword = "$baseUrl/users/auth/reset-password" ;

  /// Products
  static const String products = "$baseUrl/vendor-products";
  static const String storeProduct = "$baseUrl/products";
  static String productById(int id) => "$baseUrl/products/$id";
  static String updateProduct(int id) => "$baseUrl/products/$id";
  static String deleteProduct(int id) => "$baseUrl/products/$id";

  /// Orders
  static String publishOrder(int orderId,int vendorId) => "$baseUrl/vendors/$vendorId/orders/$orderId/publish";
  static String getAllOrders(int vendorId) => "$baseUrl/vendors/$vendorId/orders" ;
  static String getOrderDetails(int orderId) => "$baseUrl/orders/$orderId" ;

  /// Delivery Requests
  static String updateDeliveryRequestStatus(int id) => "$baseUrl/delivery-requests/$id/status";
  static String getAllDeliveryRequests(int vendorId) => "$baseUrl/delivery-requests/vendor/$vendorId";

  /// Analytics
  static String vendorAnalytics(int vendorId) => "$baseUrl/vendors/$vendorId/analytics" ;

  ///
  static String requestPickUpOTP = "$baseUrl/orders/{order_id}/otp/pickup/generate" ;
}
