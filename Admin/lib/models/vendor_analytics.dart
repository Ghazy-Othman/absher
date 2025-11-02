//
//
//
class TopProduct {
  final int productId;
  final String name;
  final int qty;
  final int priceCents;
  TopProduct({required this.productId, required this.name, required this.qty, required this.priceCents});
  factory TopProduct.fromJson(Map<String,dynamic> j) => TopProduct(
    productId: j['product_id'],
    name: j['name'],
    qty: j['qty'],
    priceCents: j['price_cents'],
  );
}

class OrdersPerDay {
  final String day;
  final int count;
  OrdersPerDay({required this.day, required this.count});
  factory OrdersPerDay.fromJson(Map<String,dynamic> j) => OrdersPerDay(day: j['day'], count: j['count']);
}

class VendorAnalytics {
  final Map<String,int> statusCounts;
  final List<TopProduct> topProducts;
  final List<OrdersPerDay> ordersPerDay;
  final int revenueTotalCents;
  final int avgOrderValueCents;
  final int deliveryRequestsTotal;
  final int totalOrders;

  VendorAnalytics({
    required this.statusCounts,
    required this.topProducts,
    required this.ordersPerDay,
    required this.revenueTotalCents,
    required this.avgOrderValueCents,
    required this.deliveryRequestsTotal,
    required this.totalOrders,
  });

  factory VendorAnalytics.fromJson(Map<String,dynamic> j) {
    final sc = Map<String,int>.from(j['status_counts'] ?? {});
    final tp = (j['top_products'] as List? ?? []).map((e) => TopProduct.fromJson(e)).toList();
    final opd = (j['orders_per_day'] as List? ?? []).map((e) => OrdersPerDay.fromJson(e)).toList();
    return VendorAnalytics(
      statusCounts: sc,
      topProducts: tp,
      ordersPerDay: opd,
      revenueTotalCents: j['revenue_total_cents'] ?? 0,
      avgOrderValueCents: j['avg_order_value_cents'] ?? 0,
      deliveryRequestsTotal: j['delivery_requests_total'] ?? 0,
      totalOrders: j['total_orders'] ?? 0,
    );
  }
}
