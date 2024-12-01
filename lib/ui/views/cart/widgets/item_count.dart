import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/models/cart_model.dart';
import 'package:usanacaixaapp/viewmodels/cart/cart_viewmodel.dart';

class ItemCount extends StatelessWidget {
  const ItemCount({
    super.key,
    required this.item,
    required this.viewmodel,
  });

  final CartItemModel item;
  final CartViewModel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            height: 35,
            width: 35,
            child: IconButton(
              iconSize: 15,
              icon: Icon(Icons.remove),
              onPressed: () {
                viewmodel.removeCartUnit(item.id);
              },
            )),
        SizedBox(
          width: 5,
        ),
        viewmodel.store.isAddUnitLoading.value &&
                viewmodel.store.idAddUnitLoading.value == item.id
            ? SizedBox(
                width: 15, height: 15, child: CircularProgressIndicator())
            : Text(
                item.quantity.toString(),
                style: TextStyle(fontSize: 15),
              ),
        SizedBox(
          width: 5,
        ),
        SizedBox(
          height: 35,
          width: 35,
          child: IconButton(
            iconSize: 15,
            icon: Icon(Icons.add),
            onPressed: () {
              viewmodel.addCartUnit(item.id);
            },
          ),
        ),
      ],
    );
  }
}
