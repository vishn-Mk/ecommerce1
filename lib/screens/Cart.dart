import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_services.dart';
import '../utils/constants.dart';
import '../view_model/cart_viewmodel.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/check_out.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Future<void>? _loadDataFuture;

  @override
  void initState() {
    super.initState();
    _loadDataFuture = _loadData();
  }

  Future<void> _loadData() async {
    final authService = AuthServices();
    await authService.loadUserId();
    final cartProvider = Provider.of<CartViewModel>(context, listen: false);
    if (authService.userId != null) {
      await cartProvider.fetchCartContents(authService.userId!, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartViewModel>();

    double getTotalPrice() {
      double total = 0.0;
      for (var item in cartProvider.cartItems) {
        double price = item.productId?.price?.toDouble() ?? 0.0;
        int qty = item.quantity ?? 0;
        total += price * qty;
      }
      return total;
    }

    int getTotalItem() {
      int totalItems = 0;
      for (var item in cartProvider.cartItems) {
        totalItems += (item.quantity ?? 0);
      }
      return totalItems;
    }

    void increment(int index) async {
      final item = cartProvider.cartItems[index];
      if (item.quantity != null) {
        int newQuantity = item.quantity! + 1;
        await cartProvider.updateCartItemQuantity(item.sId!, newQuantity, context);
      }
    }

    void decrement(int index) async {
      final item = cartProvider.cartItems[index];
      if (item.quantity != null && item.quantity! > 1) {
        int newQuantity = item.quantity! - 1;
        await cartProvider.updateCartItemQuantity(item.sId!, newQuantity, context);
      }
    }

    void deleteItem(String itemId) async {
      await cartProvider.deleteCartItem(itemId, context);
    }

    return Scaffold(
      backgroundColor: kcontentColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: const Text(
            "My Cart",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      bottomSheet: CheckOutBox(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Consumer<CartViewModel>(
                builder: (context, cartProvider, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: cartProvider.cartItems.length,
                    itemBuilder: (context, index) {
                      var item = cartProvider.cartItems[index];
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1.5,
                                ),
                              ),
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: kcontentColor,
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        item.productId?.image ?? "",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.productId?.title ?? "",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          item.productId?.category ?? "",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "\$${item.productId?.price ?? ""}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: 20,
                            child: Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (item.sId != null) {
                                      deleteItem(item.sId!);
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: kcontentColor,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          decrement(index);
                                        },
                                        icon: const Icon(Icons.remove),
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        item.quantity?.toString() ?? "1",  // Ensure correct quantity is displayed
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          increment(index);
                                        },
                                        icon: const Icon(Icons.add),
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
