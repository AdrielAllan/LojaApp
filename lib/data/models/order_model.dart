import 'package:flutter/material.dart';

class OrderModel {
  final User user;
  final OrdersSummary ordersSummary;
  final List<Order> orders;

  OrderModel({
    required this.user,
    required this.ordersSummary,
    required this.orders,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      user: User.fromMap(map['user']),
      ordersSummary: OrdersSummary.fromMap(map['orders_summary']),
      orders: List<Order>.from(map['orders'].map((order) => Order.fromMap(order))),
    );
  }
}

class User {
  final String balance;
  final String credits;

  User({
    required this.balance,
    required this.credits,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      balance: map['balance'],
      credits: map['credits'],
    );
  }
}

class OrdersSummary {
  final int totalOrders;
  final int incompleteOrders;
  final int awaitingOrders;
  final int payedOrders;
  final int completeOrders;

  OrdersSummary({
    required this.totalOrders,
    required this.incompleteOrders,
    required this.awaitingOrders,
    required this.payedOrders,
    required this.completeOrders,
  });

  factory OrdersSummary.fromMap(Map<String, dynamic> map) {
    return OrdersSummary(
      totalOrders: map['total_orders'],
      incompleteOrders: map['incomplete_orders'],
      awaitingOrders: map['awaiting_orders'],
      payedOrders: map['payed_orders'],
      completeOrders: map['complete_orders'],
    );
  }
}

class Order {
  final int id;
  final Group group;
  final String total;
  final String status;
  final Color statusBackgroundColor;
  final Color statusTextColor;
  final String createdAt;

  Order({
    required this.id,
    required this.group,
    required this.total,
    required this.status,
    required this.statusBackgroundColor,
    required this.statusTextColor,
    required this.createdAt,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      group: Group.fromMap(map['group']),
      total: map['total'],
      status: map['status'],
      statusBackgroundColor: _hexToColor(map['status_background_color']),
      statusTextColor: _hexToColor(map['status_text_color']),
      createdAt: map['created_at'],
    );
  }

  // Função para converter string hexadecimal em Color
  static Color _hexToColor(String hex) {
    final buffer = StringBuffer();

    if (hex.length == 4) {
      hex = hex.replaceFirst('#', '');
      hex = hex.split('').map((char) => char * 2).join();
    }

    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

class Group {
  final int id;
  final String storeName;

  Group({
    required this.id,
    required this.storeName,
  });

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      id: map['id'],
      storeName: map['store_name'],
    );
  }
}
