import 'package:flutter/material.dart';
import '../../shared/styles.dart';
import '../../shared/colors.dart';
import 'ProductPage.dart';
import '../../model/ProductModel.dart';
import '../../shared/fooditem.dart';
import '../../model/API.dart';
import '../../animation/FadeInAnimation.dart';
import 'SelectCategoriePage.dart';
import 'dart:convert';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var product = new List<Product>();
  var drinks = new List<Product>();

  Future _getHotdeal() async {
    APIProduct.getProduct('getlistproduct.php').then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        product = list.map((model) => Product.fromJson(model)).toList();
      });
    });
  }

  Future _getDrinks() {
    APIProduct.getProduct('getproduct3.php').then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        drinks = list.map((model) => Product.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getHotdeal();
    _getDrinks();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        headerTopCategories(),
        SizedBox(
          height: 600,
          child: listproduct(),
        ),
      ],
    );
  }

  Widget sectionHeader(String headerTitle, {onViewMore}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 15, top: 10),
          child: Text(headerTitle, style: h4),
        ),
        Container(
          margin: EdgeInsets.only(left: 15, top: 2),
          child: FlatButton(
            onPressed: onViewMore,
            child: Text('Tất cả ›', style: contrastText),
          ),
        )
      ],
    );
  }

// wrap the horizontal listview inside a sizedBox..
  Widget headerTopCategories() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        sectionHeader('Danh mục', onViewMore: () {}),
        SizedBox(
          height: 130,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: <Widget>[
              headerCategoryItem('Lương thực','assets/images/rice.png','getproduct1.php'),
              headerCategoryItem('Trái cây','assets/images/cherry.png','getproduct2.php'),
              headerCategoryItem('Rau củ','assets/images/vegetable.png','getproduct3.php'),
              headerCategoryItem('Cây giống','assets/images/seedling.png','getproduct5.php'),
              headerCategoryItem('Gợi ý','assets/images/drink.png','getproduct4.php'),
              headerCategoryItem('Nhiều hơn','assets/images/star.png','getproduct6.php'),
            ],
          ),
        )
      ],
    );
  }

  Widget headerCategoryItem(String name, String img,String url) {
    return Container(
      margin: EdgeInsets.only(left: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(bottom: 10),
              width: 86,
              height: 86,
              child: FloatingActionButton(
                shape: CircleBorder(),
                heroTag: name,
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectCategorie(url,name)),
                  );
                } ,
                backgroundColor: white,
                child: Image.asset(img,
                  width: 40,
                  height: 40,
                ),
              )),
          Text(name + ' ›', style: categoryText)
        ],
      ),
    );
  }

  Widget listproduct() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        sectionHeader('Mới nhất'),
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: product.length,
              itemBuilder: (BuildContext context, i) {
                return FadeInAnimation(
                    i.toDouble(),
                    foodItem(product[i], onTapped: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return new ProductPage(
                              productData: product[i],
                            );
                          },
                        ),
                      );
                    }, onLike: () {}));
              }),
        ),
        sectionHeader('Gợi ý'),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: drinks.length,
            itemBuilder: (BuildContext context, int i) {
              return FadeInAnimation(
                  i.toDouble()*0.2,
                  foodItem(drinks[i], onTapped: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return new ProductPage(
                            productData: drinks[i],
                          );
                        },
                      ),
                    );
                  }, onLike: () {}));
            },
          ),
        ),
      ],
    );
  }
}
