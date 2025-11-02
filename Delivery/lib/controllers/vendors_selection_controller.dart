//
//
//
class VendorSelectionController {
  ///
  List<String> selectedCategories = [];
  List<Map<String, String>> shops = [
    {"name": "TechZone", "desc": "Latest mobile and gadgets"},
    {"name": "Burger King", "desc": "Best burgers in town"},
    {"name": "FreshMart", "desc": "Daily fresh groceries"},
    {"name": "Pizza Hub", "desc": "Tasty pizzas for all cravings"},
  ];

  ///
  List<String> categories = [
    "Mobiles",
    "Restaurants",
    "Groceries",
    "Clothing",
    "Electronics",
    "Bakery"
  ];
  ///
  void toggleCategory(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }
}