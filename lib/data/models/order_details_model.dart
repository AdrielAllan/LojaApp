class OrderDetailsModel {
  final Order order;
  final List<Product> products;
  final List<StatusHistory> statusHistory;
  final bool blocked;
  final String? terms;

  OrderDetailsModel({
    required this.order,
    required this.products,
    required this.statusHistory,
    required this.blocked,
    this.terms,
  });

  factory OrderDetailsModel.fromMap(Map<String, dynamic> map) {
    return OrderDetailsModel(
      order: Order.fromMap(map['order']),
      products: List<Product>.from(map['products'].map((x) => Product.fromMap(x))),
      statusHistory: List<StatusHistory>.from(map['status_history'].map((x) => StatusHistory.fromMap(x))),
      blocked: map['blocked'],
      terms: map['terms'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'order': order.toMap(),
      'products': products.map((x) => x.toMap()).toList(),
      'status_history': statusHistory.map((x) => x.toMap()).toList(),
      'blocked': blocked,
      'terms': terms,
    };
  }
}

class Order {
  final int id;
  final String productsTotal;
  final String salesTax;
  final String serviceTax;
  final String total;
  final int status;
  final String createdAt;
  final String updatedAt;

  Order({
    required this.id,
    required this.productsTotal,
    required this.salesTax,
    required this.serviceTax,
    required this.total,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      productsTotal: map['products_total'],
      salesTax: map['sales_tax'],
      serviceTax: map['service_tax'],
      total: map['total'],
      status: map['status'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'products_total': productsTotal,
      'sales_tax': salesTax,
      'service_tax': serviceTax,
      'total': total,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Product {
  final int id;
  final String name;
  final String variation;
  final String? weight;
  final int quantity;
  final String unitPrice;
  final String totalPrice;
  final String photo;

  Product({
    required this.id,
    required this.name,
    required this.variation,
    this.weight,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.photo,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      variation: map['variation'],
      weight: map['weight'],
      quantity: map['quantity'],
      unitPrice: map['unit_price'],
      totalPrice: map['total_price'],
      photo: map['photo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'variation': variation,
      'weight': weight,
      'quantity': quantity,
      'unit_price': unitPrice,
      'total_price': totalPrice,
      'photo': photo,
    };
  }
}

class StatusHistory {
  final String status;
  final String createdAt;

  StatusHistory({
    required this.status,
    required this.createdAt,
  });

  factory StatusHistory.fromMap(Map<String, dynamic> map) {
    return StatusHistory(
      status: map['status'],
      createdAt: map['created_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'created_at': createdAt,
    };
  }
}
