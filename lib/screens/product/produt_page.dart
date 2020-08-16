import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kimirina_app/models/products_model.dart';
import 'package:kimirina_app/screens/product/product_details.dart';
import 'package:kimirina_app/services/user_service.dart';
import 'package:kimirina_app/shared/colors.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({Key key}) : super(key: key);

  _ProductScreen createState() => _ProductScreen();
}

class _ProductScreen extends State<ProductScreen> {
  List<Widget> productsCards = new List();
  final TextStyle dropdownMenuItem =
      TextStyle(color: Colors.black, fontSize: 18);

  final primary = Color(0xff696b9e);
  final secondary = Color(0xfff29a94);

  @override
  initState() {
    getProducts();
    super.initState();
  }

  var productList = <Product>[];
  var numberOfProducts = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          height: 70,
          padding: const EdgeInsets.only(top: 20.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: naranja,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              )),
          child: ListTile(
            title: Text(
              "Nuestros servicios",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        preferredSize: Size.fromHeight(90.0),
      ),
      backgroundColor: Color(0xfff0f0f0),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10),
                height: MediaQuery.of(context).size.height - 120,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: numberOfProducts,
                    itemBuilder: (BuildContext context, int index) {
                      return buildList(context, index);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    ProductDetailsPage(productDetails: productList[index])));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        width: double.infinity,
        height: 110,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 70,
              height: 70,
              margin: EdgeInsets.only(right: 15, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70),
                border: Border.all(width: 3, color: secondary),
                image: DecorationImage(
                    image: new NetworkImage(productList[index].image),
                    fit: BoxFit.fill),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    productList[index].title,
                    style: TextStyle(
                        color: primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.info,
                        color: secondary,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: AutoSizeText(
                        productList[index].description,
                        maxLines: 3,
                      )),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getProducts() {
    this.productList = new List();
    ApiService().getProducts().then((value) {
      setState(() {
        for (var i = 0; i < value["data"].length; i++) {
          productList.add(Product(
            title: value["data"][i]["title"],
            description: value["data"][i]["description"],
            image: value["data"][i]["image"],
            link: value["data"][i]["link"],
            price: value["data"][i]["price"],
            observations: value["data"][i]["observations"],
          ));
        }
        numberOfProducts = productList.length;
      });
    });
  }
}
