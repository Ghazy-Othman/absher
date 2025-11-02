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

  /// Orders
  static const String getMainPageOrders = "$baseUrl/orders/delivery";
  static const String confirmPickUp = "$baseUrl/orders/{order_id}/otp/pickup/verify";
  static const String confirmDeliver = "$baseUrl/orders/{order_id}/otp/deliver/verify";


  /// Delivery Requests
  static const String sendDeliveryRequest = "$baseUrl/delivery-requests";
  static const String cancelOrderRequest = "$baseUrl/delivery-cancel-order-request";


  ///
  static const String register = "$baseUrl/users/auth/register-delivery" ;
  static const String login = "$baseUrl/users/auth/login" ;
  static const String forgetPassword = "$baseUrl/users/auth/forget-password" ;
  static const String resetPassword = "$baseUrl/users/auth/reset-password" ;
}
