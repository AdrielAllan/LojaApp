class CartModel {
  final List<CartItemModel> cart;
  final String price;
  final String salesTax;
  final String serviceTax;
  final String totalToPay;

  CartModel({
    required this.cart,
    required this.price,
    required this.salesTax,
    required this.serviceTax,
    required this.totalToPay,
  });

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      cart: List<CartItemModel>.from(
        (map['cart'] as List).map((item) => CartItemModel.fromMap(item)),
      ),
      price: map['price'],
      salesTax: map['sales_tax'],
      serviceTax: map['service_tax'],
      totalToPay: map['total_to_pay'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cart': cart.map((item) => item.toMap()).toList(),
      'price': price,
      'sales_tax': salesTax,
      'service_tax': serviceTax,
      'total_to_pay': totalToPay,
    };
  }
}

class CartItemModel {
  final String idItemInCart;
  final String id;
  final String name;
  int quantity;
  final String size;
  final String unitPrice;
  final String totalPrice;
  final int groupId;
  final String imagePath;
  String obs;

  CartItemModel(
      {required this.idItemInCart,
      required this.id,
      required this.name,
      required this.quantity,
      required this.size,
      required this.unitPrice,
      required this.totalPrice,
      required this.groupId,
      required this.imagePath,
      required this.obs});

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
        idItemInCart: map['a'],
        name: map['b'],
        quantity: map['c'],
        size: map['d'],
        unitPrice: map['e'],
        totalPrice: map['f'],
        groupId: map['g'],
        imagePath: map['h'],
        obs: map['i'] ?? "",
        id: map['j']);
  }

  Map<String, dynamic> toMap() {
    return {
      'a': idItemInCart,
      'b': name,
      'c': quantity,
      'd': size,
      'e': unitPrice,
      'f': totalPrice,
      'g': groupId,
      'h': imagePath,
      'i': obs,
      'j': id
    };
  }
}
