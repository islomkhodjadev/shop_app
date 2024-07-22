import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:shop_app_flutter/provideCard.dart";

class ProductDetailsPage extends StatefulWidget {
  final Map<String, Object> product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late int selectedSize;
  late Map<String, Object> product;

  @override
  void initState() {
    super.initState();
    product = widget.product;
    selectedSize = 0;
  }

  void onTap() {
    if (selectedSize != 0) {
      Provider.of<CardProvider>(context, listen: false).addProduct({
        'id': product["id"],
        'title': product["title"],
        'price': product["price"],
        'imageUrl': product["imageUrl"],
        'company': product["company"],
        'size': selectedSize,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 72, 247, 102),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.info, color: Colors.white),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'product added',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (mounted) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    }
                  },
                  child: const Text('okay'),
                ),
              ],
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 254, 83, 83),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.info, color: Colors.white),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'You should choose size before adding to cart',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (mounted) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    }
                  },
                  child: const Text('okay'),
                ),
              ],
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    late List<int> sizes = widget.product["sizes"] as List<int>;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Details"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                widget.product["title"] as String,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image(
                    image: AssetImage(widget.product["imageUrl"] as String)),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 300,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromRGBO(245, 247, 249, 1),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${widget.product["price"]}"),
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: sizes.length,
                            itemBuilder: (context, index) {
                              final currentsize = sizes[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedSize = currentsize;
                                    });
                                  },
                                  child: Chip(
                                    backgroundColor: selectedSize == currentsize
                                        ? Theme.of(context).colorScheme.primary
                                        : const Color.fromRGBO(
                                            245, 247, 249, 1),
                                    label: Text(currentsize.toString()),
                                    labelStyle: const TextStyle(
                                      fontSize: 15,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    shape: const RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Color.fromRGBO(
                                                245, 247, 249, 1)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                  ),
                                ),
                              );
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.add_shopping_cart,
                              color: Colors.black),
                          onPressed: onTap,
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              minimumSize: const Size(double.infinity, 50)),
                          label: const Text("Add to cart",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      )
                    ]),
              ),
            ],
          ),
        ));
  }
}
