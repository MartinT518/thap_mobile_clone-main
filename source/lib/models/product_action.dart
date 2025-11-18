class ProductAction {
  ProductAction({required this.text, required this.onTap, this.icon});

  final String text;
  final String? icon;
  final Function() onTap;
}
