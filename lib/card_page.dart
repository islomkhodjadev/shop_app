import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "provideCard.dart";

class CardPage extends StatefulWidget {
  CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPage();
}

class _CardPage extends State<CardPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CardProvider>(context).cart;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Cart"),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: cartData.length,
          itemBuilder: (context, index) {
            final cartItem = cartData[index];
            return Dismissible(
              confirmDismiss: (direction) async {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirm Deletion'),
                      content:
                          const Text('Are you sure you want to delete it?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Delete'),
                        ),
                      ],
                    );
                  },
                );
              },
              onDismissed: (direction) {
                context.read<CardProvider>().removeProduct(cartItem);
              },
              key: Key(cartItem["title"] as String),
              background: Container(
                color: const Color.fromARGB(255, 254, 83, 83),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              direction: DismissDirection.endToStart,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(cartItem["imageUrl"] as String),
                  radius: 45,
                ),
                trailing: const Icon(Icons.more_vert),
                title: Text(
                  cartItem["title"] as String,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                subtitle: Text("Size: ${cartItem["size"]}"),
              ),
            );
          },
        ));
  }
}
