import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/constants/color_constants.dart';
import 'package:usanacaixaapp/data/utils/size_config.dart';

class Categories extends StatefulWidget {
  const Categories(
      {super.key,
      required this.categories,
      required this.press,
      required this.idGroup,
      required this.selectedIndex});

  final int idGroup;
  final Function press;
  final List<String> categories;
  final int selectedIndex;

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = ["Todos"];

  @override
  Widget build(BuildContext context) {
    categories.addAll(widget.categories);
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.getProportionateScreenWidth(15)),
      child: SizedBox(
        height: SizeConfig.screenHeight * 0.05,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) => buildCategory(index, categories)),
      ),
    );
  }

  Widget buildCategory(int index, List<String> category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.press(widget.idGroup, category[index], index);
        });
      },
      child: Padding(
        padding:
            EdgeInsets.only(right: SizeConfig.getProportionateScreenWidth(30)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              categories[index],
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: widget.selectedIndex == index
                      ? AppColors.kPrimaryColor
                      : AppColors.kSecondaryColor),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: SizeConfig.getProportionateScreenWidth(2)),
              height: SizeConfig.getProportionateScreenWidth(2),
              width: SizeConfig.getProportionateScreenWidth(30),
              color: widget.selectedIndex == index
                  ? AppColors.kPrimaryColor
                  : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
