class MarketItem {
  final String title;
  final String description;
  final String price;
  final String image;
  final String tag; // Free, New, Best Seller etc.

  MarketItem({
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.tag,
  });
}
