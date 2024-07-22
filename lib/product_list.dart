import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import "global_variables.dart";
import "product_card.dart";
import "product_details_page.dart";
import "provideCard.dart";

class ProductList extends StatefulWidget {
  ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<String> filters = ["All", "Adidas", "Nike", "Puma"];
  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    print(Provider.of<CardProvider>(context).cart);
    const border = OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 1)),
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(50),
        ));
    return SafeArea(
      child: Column(children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                "Shoes\n collection",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search",
                    border: border,
                    enabledBorder: border),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            itemBuilder: (context, index) {
              final filter = filters[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedFilter = filter;
                    });
                  },
                  child: Chip(
                    backgroundColor: selectedFilter == filter
                        ? Theme.of(context).colorScheme.primary
                        : const Color.fromRGBO(245, 247, 249, 1),
                    label: Text(filter),
                    labelStyle: const TextStyle(
                      fontSize: 15,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    shape: const RoundedRectangleBorder(
                        side:
                            BorderSide(color: Color.fromRGBO(245, 247, 249, 1)),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return ProductDetailsPage(product: product);
                  }));
                },
                child: ProductCard(
                  title: product["title"] as String,
                  price: product["price"] as double,
                  image: product["imageUrl"] as String,
                  backgroundColor: index % 2 == 0
                      ? const Color.fromRGBO(216, 243, 253, 1)
                      : const Color.fromRGBO(245, 247, 249, 1),
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}
