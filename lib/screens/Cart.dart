// import 'package:ecommerce_mobile_app/Provider/add_to_cart_provider.dart';
// import 'package:ecommerce_mobile_app/screens/Cart/check_out.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../constants.dart';
// import '../../services/auth_services.dart';
// import '../../view_model/cart_view_model.dart';
// import '../nav_bar_screen.dart';
//
// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});
//
//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen> {
//   Future<void>? _loadDataFuture;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _loadDataFuture = _loadData();
//   }
//
//   Future<void> _loadData() async {
//     final authService = AuthServices();
//     var id = await authService; // Wait for userId to load
//     print('-----------------------$id');
//     final cartProvider = Provider.of<CartViewModel>(context, listen: false);
//     if (authService.userId != null) {
//       cartProvider.fetchCartContents(authService.userId!, context);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = CartProvider.of(context);
//     final finalList = provider.cart;
//     final cartprovider = context.watch<CartViewModel>();
//
//     double getTotalPrice() {
//       double total = 0.0;
//       for (var item in cartprovider.cartItems) {
//         double price = item.productId?.price?.toDouble() ?? 0.0;
//         int qty = item.quantity ?? 0;
//         total += price * qty;
//       }
//       return total;
//     }
//
//     int getTotalItem() {
//       int totalItems = 0;
//       for (var item in cartprovider.cartItems) {
//         totalItems += (item.quantity ?? 0);
//       }
//       return totalItems;
//     }
//
//     void increment(int index) async {
//       final item = cartprovider.cartItems[index];
//       if (item.quantity != null) {
//         int newQuantity = item.quantity! + 1;
//         print('Incrementing item ${item.sId} to $newQuantity');
//         await cartprovider.updateCartItemQuantity(
//             item.sId!, newQuantity, context);
//       }
//     }
//
//     void decrement(int index) async {
//       final item = cartprovider.cartItems[index];
//       if (item.quantity != null && item.quantity! > 1) {
//         int newQuantity = item.quantity! - 1;
//         print('Decrementing item ${item.sId} to $newQuantity');
//         await cartprovider.updateCartItemQuantity(
//             item.sId!, newQuantity, context);
//       }
//     }
//
//     void deleteItem(String itemId) async {
//       await cartprovider.deleteCartItem(itemId, context);
//     }
//
//     final authprovider = AuthServices();
//     producrQuantity(IconData icon, int index) {
//       return GestureDetector(
//         onTap: () {
//           setState(() {
//             icon == Icons.add
//                 ? provider.incrementQtn(index)
//                 : provider.decrementQtn(index);
//           });
//         },
//         child: Icon(
//           icon,
//           size: 20,
//           color: Colors.white,
//         ),
//       );
//     }
//
//     return Scaffold(
//       backgroundColor: kcontentColor,
//       bottomSheet: CheckOutBox(),
//       body: SafeArea(
//           child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                   style: IconButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     padding: const EdgeInsets.all(15),
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => BottomNavBar(),
//                         ));
//                     print(cartprovider.cartData.length);
//                   },
//                   icon: const Icon(
//                     Icons.arrow_back_ios,
//                   ),
//                 ),
//                 const Text(
//                   "My Cart",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 25,
//                       color: Colors.white),
//                 ),
//                 const SizedBox()
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: cartprovider.cartData.length,
//               itemBuilder: (context, index) {
//                 var item = cartprovider.cartItems[index];
//                 // final cartItems = finalList[index];
//                 return Stack(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(15),
//                       child: Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: Colors.white,
//                         ),
//                         padding: const EdgeInsets.all(20),
//                         child: Row(
//                           children: [
//                             Container(
//                               height: 100,
//                               width: 90,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 color: kcontentColor,
//                               ),
//                               // padding: const EdgeInsets.all(20),
//                               child: Image.network(
//                                   cartprovider.cartData[index].image ?? ""),
//                             ),
//                             const SizedBox(width: 10),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   cartprovider.cartData[index].title!,
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 Text(
//                                   cartprovider.cartData[index].category!,
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 14,
//                                       color: Colors.grey.shade400),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Text(
//                                   "\$${cartprovider.cartData[index].price ?? ""}",
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       top: 35,
//                       right: 35,
//                       child: Column(
//                         children: [
//                           // for remove items
//                           IconButton(
//                             onPressed: () {
//                               // Ensure that itemId is correctly derived from the cart item
//                               String itemId = item.sId ??
//                                   ''; // Assuming sId is the correct identifier
//                               deleteItem(itemId);
//                             },
//                             icon: Icon(
//                               Icons.delete,
//                               color: Colors.red,
//                               size: 20,
//                             ),
//                           ),
//                           // for items quantity
//                           const SizedBox(height: 10),
//                           Container(
//                             height: 40,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(20),
//                               color: kcontentColor,
//                               border: Border.all(
//                                 color: Colors.grey.shade400,
//                                 width: 2,
//                               ),
//                             ),
//                             child: Row(
//                               children: [
//                                 const SizedBox(width: 10),
//                                 // producrQuantity(Icons.add, index),
//                                 IconButton(
//                                   onPressed: () {
//                                     increment(index);
//                                   },
//                                   icon: Icon(Icons.add),
//                                   color: Colors.blue,
//                                 ),
//                                 const SizedBox(width: 10),
//                                 Text(
//                                   cartprovider.cartItems[index].quantity
//                                           .toString() ??
//                                       "",
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 10),
//                                 IconButton(
//                                   onPressed: () {
//                                     decrement(index);
//                                   },
//                                   icon: Icon(Icons.remove),
//                                   color: Colors.blue,
//                                 ),
//                                 // producrQuantity(Icons.remove, index),
//                                 const SizedBox(width: 10),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ],
//       )),
//     );
//   }
// }


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
    var id = await authService; // Wait for userId to load
    final cartProvider = Provider.of<CartViewModel>(context, listen: false);
    if (authService.userId != null) {
      await cartProvider.fetchCartContents(authService.userId!, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartprovider = context.watch<CartViewModel>();

    double getTotalPrice() {
      double total = 0.0;
      for (var item in cartprovider.cartItems) {
        double price = item.productId?.price?.toDouble() ?? 0.0;
        int qty = item.quantity ?? 0;
        total += price * qty;
      }
      return total;
    }

    int getTotalItem() {
      int totalItems = 0;
      for (var item in cartprovider.cartItems) {
        totalItems += (item.quantity ?? 0);
      }
      return totalItems;
    }

    void increment(int index) async {
      final item = cartprovider.cartItems[index];
      if (item.quantity != null) {
        int newQuantity = item.quantity! + 1;
        await cartprovider.updateCartItemQuantity(
            item.sId!, newQuantity, context);
      }
    }

    void decrement(int index) async {
      final item = cartprovider.cartItems[index];
      if (item.quantity != null && item.quantity! > 1) {
        int newQuantity = item.quantity! - 1;
        await cartprovider.updateCartItemQuantity(
            item.sId!, newQuantity, context);
      }
    }

    void deleteItem(String itemId) async {
      await cartprovider.deleteCartItem(itemId, context);
    }

    return Scaffold(
      backgroundColor: kcontentColor,
      bottomSheet: CheckOutBox(),
      body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(15),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavBar(),
                            ));
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                      ),
                    ),
                    const Text(
                      "My Cart",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white),
                    ),
                    const SizedBox()
                  ],
                ),
              ),
              Expanded(
                child: Consumer<CartViewModel>(
                  builder: (context, cartprovider, child) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: cartprovider.cartItems.length,
                      itemBuilder: (context, index) {
                        var item = cartprovider.cartItems[index];
                        return Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 90,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: kcontentColor,
                                      ),
                                      child: Image.network(
                                          cartprovider.cartData[index].image ?? ""),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cartprovider.cartData[index].title!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          cartprovider.cartData[index].category!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.grey.shade400),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "\$${cartprovider.cartData[index].price ?? ""}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    )
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
                                      String itemId = item.sId ?? '';
                                      deleteItem(itemId);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: kcontentColor,
                                      border: Border.all(
                                        color: Colors.grey.shade400,
                                        width: 2,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            increment(index);
                                          },
                                          icon: Icon(Icons.add),
                                          color: Colors.blue,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          item.quantity.toString() ?? "",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        IconButton(
                                          onPressed: () {
                                            decrement(index);
                                          },
                                          icon: Icon(Icons.remove),
                                          color: Colors.blue,
                                        ),
                                        const SizedBox(width: 10),
                                      ],
                                    ),
                                  )
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
          )),
    );
  }
}